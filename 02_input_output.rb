# Write a program that accepts someone's name and age, and responds
# as shown here:

puts "What is you name"
name = gets.chomp.capitalize
puts "Hi #{name} What is your age"
age = gets.chomp.to_i
puts "Wow! you are #{age} years old Congratulations!"
age100 = 100 - age.to_i
puts "#{name} in #{age100} years you will be 100 years old!"

# Program is run and outputs:
# "What is your name?"

# User inputs: "Tom"

# Program outputs:
# "Hi Tom! How old are you?"

# User inputs: 40

# Program outputs:
# "Wow! You are 40 years old. Congratulations!"

# Beast mode challenge:
# Ater the above, the program calculates how many years until
# the user is 100 years old and tells the user. For example, for
# our user input above (Tom and 40), after outputing 
# "Wow! You are 40 years old. Congratulations!"
# The program also outputs:
# "Tom, in 60 years you will be 100 years old!"
