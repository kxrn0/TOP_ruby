descriptor = IO.sysopen "data.txt", "r"
file = IO.new descriptor

while line = file.gets
  puts line
end

file.close
