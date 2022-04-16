# Mastermind

# [x] method to randomly generate the four colour code
# [x] method to display it
# [x] choose to be a code-maker or a code-breaker
# [x] method to ask for the number of turns

# [x] put classes into their own file and import them
# [x] method to decide how many rounds to play, must be even number
# [x] method to let code-maker set 4 colours, delete them, edit, etc
# [x] method to print out your guesses with colours

# Breaker:
# [x] Player method to guess a code
# [x] Compute method to guess a code
#   [x] level 1 random
#   [] level 2 mid - it will always use a black again
#   [] level 3 hard - 50% chance it will correctly insert a black.
    # if the computer has guessed the right color but the wrong position,
    # its next guess will need to include that color somewhere.

# Maker
# [x] Player method to specify the feedback pegs
#   [] method to choose which pegs to place
#   [] can be an extension of the method to choose a code
# [x] Computer method to specify the feedback pegs

# Game Loop
# [x] First ask breaker to make a guess
# [x] Check if its correct
#   [x] display feedback pegs on side of board
#   [x] display turn number on board
#   [x] if it is, game over

# show board after win

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
$peg_keys = $peg.first(6).map {|key, val| key}

white = "White".bg_gray
black = "Black".bg_black

$rules = "This is a one player game against the computer. You can play as either the
Code Maker or Code Breaker.

The Code Maker sets a four-digit code using six-coloured pegs [ #{display_pegs} ],
and the Code Breaker has to guess it within a set number of turns. 

After the Breaker's guess, the Maker gives them clues via Black or White pegs,
to let them know which ones they got correct:

- A #{black} Peg for each correct guess of position and colour.
- A #{white} Peg for each correct guess of colour but with wrong position."


# Game Starts
# ======================================================

welcome_message

# Ask player to choose Breaker or Maker
player_get_role
$winner = $player[:maker] # defaults to maker unless breaker gets it.

# Ask how many turns the game will last
player_set_turns
build_game_array
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
  puts "\n Code Breaker's Turn (#{$player[:breaker].type.capitalize}):"
  $player[:breaker].guess_code
  $game_array[x] = display_code( $player[:breaker].guess )

  # Check Breaker's Guess
  if compare_code_to_guess($player[:breaker].guess) == true
    $winner = $player[:breaker]
    break
  end

  # Maker's Turn
  puts "\n Code Maker's Turn (#{$player[:maker].type.capitalize}):"
  $player[:maker].set_pegs
  
  # Update Game Board with Result
  $game_array[x] << display_code($player[:maker].feedback_pegs)
  puts $game_array
  puts "  Code  "
  puts display_code($code)

  # Prompt for next turn 
  # [] only prompt if computer is guessing
  puts "Next Turn (#{x})... (any key)"
  gets.chomp

end

puts "Winner: #{$winner.type.capitalize}. Total rounds: #{$total_rounds}"