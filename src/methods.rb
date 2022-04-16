# Methods
# ======================================================

# Game Setup
def welcome_message
  puts "\n"
  puts "Welcome to Mastermind"
  puts "=====================\n"
  puts $rules
end

def build_game_array
  row = "[ ___ ___ ___ ___ ]"
  $number_of_turns.times do
    $game_array << row
  end
end

def player_get_role
  puts "\nPlay as Code Breaker or Code Maker?"
  puts "Press a key: [1: Maker] [2: Breaker]"
  
  role_choice = gets.chomp
  
  if role_choice == '1' || role_choice == "" || role_choice == " "
    puts "You choose Code Maker."
    $player = {maker: Code_Maker.new("you"), breaker: Code_Breaker.new("computer")}

  elsif role_choice == '2'
    puts "You choose Code Breaker."
    $player = {maker: Code_Maker.new("computer"), breaker: Code_Breaker.new("you")}
  
  else
    puts "\nInvalid key, please try again."
    player_get_role
  end
end

def player_set_turns
  loop do
    puts "\nHow many guesses? 6, 8, 10 or 12 (default)."
    choice = gets.chomp

    if choice != '6' && choice != '8' && choice != '10' && choice != '12'
      $number_of_turns = 12
      break
    else
      $number_of_turns = choice.to_i
      break
    end
  end
end


# Misc
def display_pegs
  "#{$peg[1]} #{$peg[2]} #{$peg[3]} #{$peg[4]} #{$peg[5]} #{$peg[6]}"
end

def display_code(code = $code)
  "[ #{$peg[code[0]]} #{$peg[code[1]]} #{$peg[code[2]]} #{$peg[code[3]]} ]"
end

def code_generate_randomly
  code = []
  4.times { code << Random.new.rand(1..6) }
  return code
end

def compare_code_to_guess(guess)
  return true if $player[:breaker].guess == $code
end

