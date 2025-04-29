family = { uncles: ["bob", "joe", "steve"],
           sisters: ["jane", "jill", "beth"],
           brothers: ["frank", "rob", "david"],
           aunts: ["mary", "sally", "susan"] }

relevant = family.select do |title, members|
  if title == :brothers || title == :sisters
    true
  else
    false
  end
end

siblings = []

relevant.values.each { |members| siblings += members }

puts siblings
