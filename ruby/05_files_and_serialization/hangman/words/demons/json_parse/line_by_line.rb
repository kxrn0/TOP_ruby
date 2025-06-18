# frozen-string-literal: true

require 'json'

lines = ''

File.readlines('data.json').each do |line|
  lines += line

  puts line
end

puts JSON.parse lines
