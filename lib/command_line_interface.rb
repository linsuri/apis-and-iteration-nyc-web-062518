require 'pry'

def welcome
  # puts out a welcome message here!
  puts "Welcome to Star Wars API!"
end

def get_character_from_user
  puts "Please enter a character"
  # use gets to capture the user's input. This method should return that input, downcased.
  input = gets.chomp
end
