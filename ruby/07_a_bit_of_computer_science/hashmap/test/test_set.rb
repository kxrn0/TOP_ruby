# frozen_string_literal: true

require_relative '../lib/hash_set'

set = HashSet.new

set.add 'javascript'
set.add 'ruby'
set.add 'c'
set.add 'doro'

puts "has ruby? #{set.has? 'ruby'}"
puts "has python? #{set.has? 'python'}"

puts 'entries:'
puts set.entries

puts 'removing python...'
set.remove 'python'
set.remove 'nothing'

puts 'entries:'
puts set.entries

puts set.length
