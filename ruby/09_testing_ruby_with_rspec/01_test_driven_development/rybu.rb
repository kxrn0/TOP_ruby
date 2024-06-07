=begin
  1.- What is the red-green-refactor cycle?

  A way of writting code that consists of first writting the tests that are expected
  to pass for that piece of code. Since the code hasn't been written yet, the tests will
  fail.
  After writting the tests we write the code to make the tests pass. The code without 
  regards for best practices, the only goal is to make the tests for that piece of code
  pass.
  After all tests pass we refactor the code.
=end

=begin
  2.- What is the difference between unit and integration tests?

  A unit test tests a component in isolation, while an integration test tests many parts of 
  the application at the same time.
=end

=begin
  3.- How does TDD help in code refactoring?

  It's safer to modify existing code, since the tests will indicate what functionality is 
  broken, if any, after refactoring.
=end
