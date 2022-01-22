=begin
Reduce sets the accumulator to the return value of the block, and then passes the accumulator to the 
block on the next yield. Your reduce should take at least 1 argument that represents the array we'll 
operate on. It should also take an optional second argument that represents the default value for the 
accumulator.
=end

array = [1, 2, 3, 4, 5]

reduce(array) { |acc, num| acc + num }                    # => 15
reduce(array, 10) { |acc, num| acc + num }                # => 25
reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass