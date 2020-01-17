# timed-calculator
Quick calculator app coded in an hour to test development speed. Implements basic arithmetic functions.

Some thoughts:
Mix of xib and programatic isn't ideal; I'd rather commit entirely to a programmatic approach. I used stack views for the button layout, but a collection view with scrolling disabled might be faster and allow for easier modification in the future. For a more advanced calculator, I'd probably implement a queue to handle order of operations.

Case matching in numberButtonPressed isn't ideal; I'd consider replacing with regex pattern matching.
