For each day, check the difference between each other day in the future and this day. I'll have to keep track of the current highest pair. It would be good to keep track of the highest sum seen until now.

At some point I'll have a pair and a sum, for example [4, 7], 1000. I'll be checking two other indices, say [13, 18], and if I find their difference to be highest than the currently highest sum, for example 2000, I'll replace the current data with the new one, so the new pair and sum are [13, 18], 2000.

What do Initialize the pair and sum to? I can initialize the sum to `-Float::INFINITY`, but what about the pair? Maybe the pair should be initialized to the first two elements, and the sum to their difference?
