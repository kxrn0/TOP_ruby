### 1. What do you name the folder that contains your test files?

$A:$

spec

### 2. What does the keyword describe define?

$A:$

A group of tests for a class or method.

### 3. What does the keyword it define?

$A:$

A test.

### 4. How many expect clauses can you write for one test case?

$A:$

One

### 5. What are some of RSpec’s equality matchers?

$A:$

- `eq` - Equivalent to comparing with `==`.
- `be` - Equivalent to comparing with `equal?`.
- `eql` - Equivalent to `eql?`.
- `equal` - Equivalent to `equal?`.
- `==` - Equivalent to `==`.

### 6. How do we tell RSpec where to find the code to be tested?

$A:$

By requiring it. We can `require_relative` relative to where the test file is, or just `require` relative to the root directory if `rspec` is called there.
