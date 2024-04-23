require "csv"
require "erb"
require "google/apis/civicinfo_v2"

civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
civic_info.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"

def clean_zipcode(zip)
  zip.to_s.rjust(5, "0")[0..4]
end

def format_phone(phone)
  return nil unless phone

  first = phone[0, 3]
  second = phone[2, 3]
  third = phone[6, 10]

  "(#{first}) #{second} #{third}"
end

def clean_phone(phone)
  digits = Array.new(10) { |n| n.to_s }
  phone = phone.split("").filter { |c| digits.include? c }.join("")

  if phone.size < 10
    return nil
  elsif phone.size == 10
    return phone
  elsif phone.size == 11
    if phone[0] == "1"
      return phone[1, phone.size]
    end
  end

  nil
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"

  begin
    legislators = civic_info.representative_info_by_address(
      address: zip,
      levels: "country",
      roles: ["legislatorUpperBody", "legislatorLowerBody"],
    ).officials
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def save_file(dir, name, contents)
  Dir.mkdir dir unless Dir.exist? dir

  filename = "#{dir}/#{name}"

  File.open(filename, "w") { |file| file.puts contents }
end

def make_letter
  template_letter = File.read "form_letter.erb"
  erb_template = ERB.new template_letter

  contents = CSV.open(
    "event_attendees.csv",
    headers: true,
    header_converters: :symbol,
  )

  contents.each do |row|
    id = row[0]
    name = row[:first_name]
    phone = format_phone clean_phone row[:homephone]
    zipcode = clean_zipcode row[:zipcode]
    legislators = legislators_by_zipcode zipcode
    form_letter = erb_template.result binding
    dir = "output"
    name = "thanks_#{id}.html"

    save_file dir, name, form_letter
  end

  contents.close
end

def compute_average_time
  contents = CSV.open(
    "event_attendees.csv",
    headers: true,
    header_converters: :symbol,
  )
  lines = 0
  average_time = 0
  table = Array.new 24, 0

  contents.each do |row|
    parts = row[:regdate].split[1].split ":"
    hours = parts[0].to_i
    minutes = hours * 60 + parts[1].to_i

    table[hours] += 1
    average_time += minutes
    lines += 1
  end

  begin
    average_time /= lines
    hours = (average_time / 60).to_s.rjust 2, "0"
    minutes = (average_time % 60).to_s.rjust 2, "0"
    time = "#{hours}:#{minutes}"

    { table: table, time: time }
  rescue
    nil
  end
end

def get_most_active_hours
  average = compute_average_time

  return unless average

  template_log = File.read "time.erb"
  erb_template = ERB.new template_log
  log = erb_template.result binding
  dir = "logs"
  name = "time.csv"

  save_file dir, name, log
end

get_most_active_hours

# make_letter
