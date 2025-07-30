### 1. What is the “red-green-refactor” cycle?

$A:$

The cycle of first writting a failing test, then writting code to make the test pass, regardless of whether or not the code works for every situation, and finally refactoring the code.

The cycle is said to be driven by the two rules

1. Write new code only if you first have a failing automated test.
2. Eliminate duplication.

So the refactor part comes after we notice duplication, which often will be hardcoding values to make the test pass, so once we are hardcoding stuff it's time to refactor.

### 2. What is the difference between unit and integration tests?

Unit tests are small and fast because they test units in isolation. Such units are often class methods.

Integration tests test that a system of the program works together. The system consisting of the interplay between several units.

### 3. How does TDD help in code refactoring?

$A:$

We can modify code with the reassurance that if we break something the tests will catch that, so as long as the tests continue to be green we are certain the new code won't break, but that assumes the tests handle every possible corner case that may arise.
