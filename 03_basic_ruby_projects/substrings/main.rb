def substrings string, dictionary
  string.downcase!

  subs = Hash.new 0

  dictionary.each do |word|
    i = 0
    while i < string.length
      if string[i] == word[0] 
        sub = string[i, word.size]

        if sub == word
          subs[sub] += 1
          i += word.length - 1
        end
      end
      i += 1
    end
  end
  subs
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

p substrings("below", dictionary)
p substrings("Howdy partner, sit down! How's it going?", dictionary)


