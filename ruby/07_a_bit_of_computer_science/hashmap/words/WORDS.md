# HashMap

A hashmap is an array that stores linked lists.

How do I downsize? Assume the base size is 4, and the load factor 1, thus we'll be doubling the capacity at the fifth item. We'll double it again at the ninth, item, and so on. Imagine we end up with a capacity of 32, that would happen after adding the 17th item. If we now remove the 17th item, and the 16th, and so on we'd be using way more memory than needed, so we need to downsize.

By how much and when do we do it? If the capacity is over twice the `length`, we should set it to `length`, at least in this case where the load factor is 1.

When `length` is larger than the capacity times the load factor we double the capacity. When do we decrease it? When the product of the capacity and load factor is over twice the `length`? In practice the load factor will be less than or equal to one. If it's one, then if said product is over twice `length`, then that means we have over twice the number of slots in the array. If the load factor is less than one, like 0.75, then we'd have even more empty slots, so I guess halving the capacity at that point sounds reasonable. We just need to remember to set it to no less than the base size.
