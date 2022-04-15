# Mastermind

# [x] method to randomly generate the four colour code
# [x] method to display it
# [x] choose to be a code-maker or a code-breaker
# [x] method to ask for the number of turns

# [x] put classes into their own file and import them
# [x] method to decide how many rounds to play, must be even number
# [x] method to let code-maker set 4 colours, delete them, edit, etc
# [ ] method to check if the guess matches the code
# [ ] method to print out your guesses with colours

# 3 difficulty settings for computer: easy (random) mid/high based on an algorithm

# config: blanks allowed? duplicates allowed?

# Import
require_relative 'src/classes.rb'
require_relative 'src/methods.rb'

# Vars
$code = []
$game_array = []
$peg = {
    1 => " 1 ".bg_red,
    2 => " 2 ".bg_green,
    3 => " 3 ".bg_brown,
    4 => " 4 ".bg_blue,
    5 => " 5 ".bg_magenta,
    6 => " 6 ".bg_cyan
  }
$game_over = false
$rules = " One player is the code-maker and the other is the code-breaker. The code-maker sets
a code of four code pegs, from a set of six colours. The code-breaker has to guess
the correct sequence of code pegs."


# Game Starts
# ======================================================

welcome_message

# Ask player to choose Breaker or Maker
player_get_choice

# Ask how many turns the game will last
player_set_turns
puts "You chose: #{$number_of_turns} guesses."

# Code maker starts by making the code
$player[:maker].make_code

# Loop for number_of_turns, code_breaker tries to guess
puts "\n\n"
puts "=========="
puts "Start Game"
puts "==========\n"

$number_of_turns.times do |x|
  puts "\n\n    Round #{x+1}/#{$number_of_turns}"

  puts $game_array

  $player[:breaker].guess_code
  puts "Guess: #{$player[:breaker].guess}"
  puts "Code: #{$code}"

  $game_over = true if $player[:breaker].guess == $code
  break if $game_over == true
end