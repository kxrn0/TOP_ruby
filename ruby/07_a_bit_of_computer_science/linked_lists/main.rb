# frozen_string_literal: true

require_relative 'lib/list'

# append

puts '------------------'
puts 'appending...'

list = List.new
numbers = (5..10).to_a

numbers.each { |n| list.append n }

puts list

# prepend

puts '------------------'
puts 'prepending...'

srebnum = (1..4).to_a.reverse

srebnum.each { |n| list.prepend n }

puts list

# size

puts '------------------'
puts 'sizing...'

puts "size: #{list.size}"

another_empty_list = List.new

puts "size of empty list: #{another_empty_list.size}"

another_empty_list.prepend 200

puts "size of list with one element: #{another_empty_list.size}"

# tail

puts '------------------'
puts 'tailing...'

puts "tail: #{list.tail}"

empty_list = List.new

puts "tail of empty list: #{empty_list.tail}"

empty_list.append 100

puts "tail of list with one element: #{empty_list.tail}"

# at

puts '------------------'
puts 'atting...'

(0...10).each do |n|
  puts "##{n}: #{list.at n}"
end

# pop

puts '------------------'
puts 'popping...'

5.times { puts list.pop }
puts list

# contains?

puts '------------------'
puts 'containing...'

(-10..10).each do |n|
  puts "#{n}: #{list.contains?(n) ? 'true' : 'false'}"
end

# find

puts '------------------'
puts 'finding...'

puts list

(-10..10).each do |n|
  puts "#{n}: #{list.find n}"
end

# insert_at

puts '------------------'
puts 'inserting at...'

puts list
list.insert_at 100, 2
puts list

begin
  puts 'inserting at index 10'
  list.insert_at 200, 10
rescue StandardError => e
  puts e
end

small_list = List.new

small_list.prepend 10

puts 'inserting into single element list'

small_list.insert_at 0, 0

puts small_list

# remove_at

puts '------------------'
puts 'removing at...'

list.remove_at 2
puts list

puts 'removing from 1 on small list'

small_list.remove_at 1

puts small_list

puts 'removing from 0 on small list'

small_list.remove_at 0

puts small_list
