### $1.-$ What does it mean to hash?

$A:$

To get a value B from another value A by means of a pure function, so the function will always generate the same output for a given input.

### $2.-$ What are buckets?

$A:$

The places in the array where the elements of a hash are stored. They can be regular array slots if the hash table is implemented with open adressing, or contain a linked list with separate chaining.

### $3.-$ What is a collision?

$A:$

When two different keys result in the same index.

### $4.-$ When is it a good time to grow our table?

$A:$

When the total number of items in the hash table is greater than the product of the total number of slots in the array times the load factor.
