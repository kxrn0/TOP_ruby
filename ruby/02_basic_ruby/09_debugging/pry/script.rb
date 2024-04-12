require "pry-byebug"

def is_isogram? string
  original_length = string.length
  string_array = string.downcase.split

  binding.pry

  unique_length = string_array.length
  original_length == unique_length
end

is_isogram? "odin"
