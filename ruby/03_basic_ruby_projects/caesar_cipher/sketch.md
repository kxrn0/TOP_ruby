Assume the alphabet is just [a,e,i,o,u].
Consider the string "eeiai". Imagine you want to shift it by two characters. From the table we can see that
e -> o
e -> o
i -> u
a -> i
i -> u
so we end up with "oouiu". Now assume we want to shift the original string by 7 places. From the table we get
e -> o
e -> o
i -> u
a -> i
i -> u
If we map each letter to its index in the array we get
{a: 0, e: 1, i: 2, o: 3, u: 4}
In the last example, shifting e by 7 characters gives us (1 + 7) % 5 = 3 = o. So we need to know the length of the alphabet, and map the letters to indices from zero to the lenght of the alphabet.

The program will split the string, map the characters, and join them.
Assume we are only working with lowercase for now. We first have to check if we are dealing with an alphabetic character. Since we are only working with lowercase we can just check if the current character matches? /[a-z]/. If not, then we return the character as it is, otherwise we find its order, substract 97, add the shift, modulate with the length of the alphabet, and finally convert it back to a character.
But I need to keep track of casing. Take some random character c. If c == c.upcase, then we are dealing with an uppercase character. Store the ascii shift variable like this `ascii_shift = c == c.upcase ? 60 : 97`, then get the order of the character, substract the ascii shift, and do the caesar shift. After that, add back the ascii shift, and convert the number to a character.
