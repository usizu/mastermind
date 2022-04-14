# Mastermind

# method to randomly generate the four colour code
# method to display it
# method to check it
# method to print out your guesses with colours
# method to decide how many rounds to play, must be even number
# choose to be a code-maker or a code-breaker
# method to let code-maker set 4 colours, delete them, edit, etc
# method to ask if player is codebreaker or maker
# 3 difficulty settings for computer: easy (random) mid/high based on an algorithm

# config: blanks allowed? duplicates allowed?

# method to ask for the number of turns
# gameloop where code-breaker tries to guess the pattern

# Vars
rules = "
One player is the code-maker and the other is the code-breaker. The code-maker sets
a code of four code pegs, from a set of six colours. The code-breaker has to guess
the correct sequence of code pegs."

# Game Logic
puts "\n"
puts "Welcome to Mastermind"
puts "=====================\n"

puts rules
# test