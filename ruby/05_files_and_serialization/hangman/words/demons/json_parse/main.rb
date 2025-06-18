# frozen-string-literal: true

require 'json'

file = File.read 'data.json'

puts JSON.parse file
