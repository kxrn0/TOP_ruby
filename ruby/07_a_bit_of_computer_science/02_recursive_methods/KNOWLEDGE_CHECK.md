### $1.-$ How would you briefly define a recursive function?

$A:$

A function that calls itself.

### $2.-$ What is the point of recursion? Is it more efficient than using a plain loop?

$A:$

Some problems are more easily solved with recursion, for example problems that deal with nested data structures.

Recursion solutions can be simpler than iterative ones, however they can be more expensive in terms of memory as each function call needs space to keep track of variables declared there.

### $3.-$ What are the 2 essential parts in a recursive function?

$A:$

The exit condition, and recursive call.

The exit condition ensures that the code won't enter an infinite loop with the function calling itself over an over, while the recursive call is where the function calls itself.

### $4.-$ Why is “stack overflow” relevant to a recursive problem?

$A:$

When a function calls itself it needs some space in memory to keep track of things like variables, so that context is put on top of the call stack, however the memory of most computers is finite, so after too much stacking of contexts in the call stack, the computer runs out of memory.
