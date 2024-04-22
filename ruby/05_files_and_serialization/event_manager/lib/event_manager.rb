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

def save_letter(id, form_letter)
  Dir.mkdir "output" unless Dir.exist? "output"

  filename = "output/thanks_#{id}.html"

  File.open(filename, "w") { |file| file.puts form_letter }
end

template_letter = File.read("form_letter.erb")
erb_template = ERB.new template_letter

contents = CSV.open(
  "event_attendees.csv",
  headers: true,
  header_converters: :symbol,
)

Dir.mkdir "output" unless Dir.exist? "output"

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  phone = format_phone clean_phone row[:homephone]
  zipcode = clean_zipcode row[:zipcode]
  legislators = legislators_by_zipcode zipcode
  form_letter = erb_template.result binding

  save_letter id, form_letter
end
