# frozen_string_literal: true

require_relative '../lib/hashmap'

map = HashMap.new

map.set('apple', 'red')
map.set('banana', 'yellow')
map.set('carrot', 'orange')
map.set('dog', 'brown')
map.set('elephant', 'gray')
map.set('frog', 'green')
map.set('grape', 'purple')
map.set('hat', 'black')
map.set('ice cream', 'white')
map.set('jacket', 'blue')
map.set('kite', 'pink')
map.set('lion', 'golden')

map.print_debug_info

map.set('lion', 'yellow')
map.set('dog', 'black')
map.set('banana', 'golden')

map.print_debug_info

map.set('moon', 'silver')

map.print_debug_info

# get

puts 'getting...'
puts '----------'

value = map.get 'elephant'
puts "elephant: #{value}"

value = map.get 'nothing'
puts "nothing: #{value}"

# has?

puts 'has?ing...'
puts '----------'

puts "has kite? #{map.has? 'kite'}"
puts "has doro? #{map.has? 'doro'}"

# remove

puts 'removing...'
puts '----------'

puts 'removing ice cream...'
map.remove 'ice cream'

puts "has ice cream? #{map.has? 'ice cream'}"

puts 'removing grape...'
map.remove 'grape'

puts "has grape? #{map.has? 'grape'}"

puts 'removing doro...'
map.remove 'doro'
puts "has doro? #{map.has? 'doro'}"

# keys/values/entries

puts 'keysing/valuesing/entriesing...'
puts '----------'

puts "keys: #{map.keys}"
puts "values: #{map.values}"
puts "entries: #{map.entries}"
