We are given the example with the word "below", and an array with the words "below", and "low", among others which are not in the given string.

The basic logic is "For each word in the dictionary, check if it is in the given string, and how many times.".

What does that mean? Consider the strings `str = "abcdebcabebc", d = "bc"`. We can see that `d` is a substring of `str` in various parts.

For each character in `str`, if the current character is equal to the first character, find a substring from the current index to the current index plus teh length of the current word. If the word and the substring are equal, increase the count for the current word, and advance the index by the length of the word.
