# Hotel Reservation

## Instructions

* The executable file is the `./reservation`
* I added the samples given in the email on the file `./sample_inputs.txt`
* To run the application just run `$ ./reservation < sample_inputs.txt`
* To run the tests `bundle install && rspec spec`
* To check the syntax `rubocop ./lib/ ./reservation`

## About the solution

Since the idea was to develop something scalable and ready for production I
tried to break into very small components, easy to understand and test.

I developed first the parsers, since it is easier to test, to the helpers
and models and finally the runner. When I had a very basic working and testable
code I organized the source and started refactoring, keeping the cycle
( red -> green -> refactor ).

I tried to test as much components as possible instead on focusing in testing
sample inputs.
