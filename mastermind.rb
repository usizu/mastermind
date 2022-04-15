# Mastermind

# [x] method to randomly generate the four colour code
# [x] method to display it
# [x] choose to be a code-maker or a code-breaker
# [x] method to ask for the number of turns

# [x] put classes into their own file and import them
# [ ] method to check if the guess matches the code
# [ ] method to print out your guesses with colours
# [ ] method to decide how many rounds to play, must be even number
# [ ] method to let code-maker set 4 colours, delete them, edit, etc

# 3 difficulty settings for computer: easy (random) mid/high based on an algorithm

# config: blanks allowed? duplicates allowed?

# gameloop where code-breaker tries to guess the pattern

# Import
require_relative 'src/classes.rb'
require_relative 'src/methods.rb'

# Vars
$rules = "
One player is the code-maker and the other is the code-breaker. The code-maker sets
a code of four code pegs, from a set of six colours. The code-breaker has to guess
the correct sequence of code pegs."

# Methods
# ======================================================

# Game Logic
welcome_message

# Ask player to be Breaker or Maker
player_get_choice

# Ask how many turns the game will last
player_set_turns
puts "You chose: #{$guesses} guesses."

# Start game loop as your role
# code maker starts by making the code
$player[:maker].make_code
