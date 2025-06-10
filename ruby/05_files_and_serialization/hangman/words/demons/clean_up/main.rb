# frozen_string_literal: true

def clean_up(filename, outputname)
  exists = File.exist? filename

  raise "file #{filename} not found!" unless exists

  words = File.open filename, 'r'
  output = File.new outputname, 'w'

  while (line = words.gets)
    output.puts line if line.chomp.size > 5
  end

  output.close
  words.close
end

clean_up 'words.txt', 'dictionary.txt'
