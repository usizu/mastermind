# Mastermind

# [x] method to randomly generate the four colour code
# [x] method to display it
# [x] choose to be a code-maker or a code-breaker
# [x] method to ask for the number of turns

# [x] put classes into their own file and import them
# [x] method to decide how many rounds to play, must be even number
# [x] method to let code-maker set 4 colours, delete them, edit, etc
# [x] method to print out your guesses with colours
# [ ] method to check if the guess matches the code

# Breaker:
# [] Player method to guess a code
# [] Compute method to guess a code

# Maker
# [] Player method to specify the feedback pegs
# [] Computer method to specify the feedback pegs

# Game Loop
# [x] First ask breaker to make a guess
# [] Check if its correct
#   [] if not, ask maker to give feedback pegs
#   [] display feedback pegs on side of board
#   [] display turn number on board
#   [] if it is, game over


# [] game_array should be of length of number_of_turns
# [] print game_array to show how many turns are left

# [] generate random guess
# [] check guess with code
# [] generate black/white peg feedback
# [] each turn, the guesses and feedback are added to a
#   parent array, and displayed in sequence


# [] 3 difficulty settings for computer: easy (random) mid/high based on an algorithm

# [] config: blanks allowed? duplicates allowed?

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
    6 => " 6 ".bg_cyan,
    :black => " B ".bg_black,
    :white => " W ".bg_gray,
    nil   => "___",
  }
$game_over = false
$rules = " One player is the code-maker and the other is the code-breaker. The code-maker sets
a code of four code pegs, from a set of six colours. The code-breaker has to guess
the correct sequence of code pegs."


# Game Starts
# ======================================================

welcome_message

# Ask player to choose Breaker or Maker
player_get_role

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
  $total_rounds = x
  puts "\n    Round #{x+1}/#{$number_of_turns}"

  # Breaker's Turn
  puts "\n Code Breaker's Turn: (#{$player[:breaker].type.capitalize})"
  $player[:breaker].guess_code

  # Check 
  $game_over = compare_code_to_guess($player[:breaker].guess)
  break if $game_over == true

  # Display Result
  $game_array[x] = display_code( $player[:breaker].guess )
  puts $game_array
  puts "Guess: #{display_code($player[:breaker].guess)}"
  puts "Code:  #{display_code($code)}"

  
  # Maker's Turn
  puts "\n Code Maker's Turn: (#{$player[:maker].type.capitalize})"
  $player[:maker].set_pegs
  # $game_array - add guess to sidebar $player[:maker].feedback_pegs
  $game_array[x] << display_code($player[:maker].feedback_pegs)

  puts "Guess Failed"
  puts "Next Round?"
  gets.chomp

end

puts "Guess correct! Total rounds: #{$total_rounds}"