=begin
Exception Assertions

Write a minitest assertion that will fail unless employee.hire raises a NoExperienceError exception.
=end

assert_raises(NoExperienceError) {employee.hire}