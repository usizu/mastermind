# Methods
# ======================================================

def welcome_message
  puts "\n"
  puts "Welcome to Mastermind"
  puts "=====================\n"
  puts $rules
end

def display_peg_colour_numbers
  "#{$peg[1]} #{$peg[2]} #{$peg[3]} #{$peg[4]} #{$peg[5]} #{$peg[6]}"
end

def display_code
  "[ #{$peg[$code[0]]} #{$peg[$code[1]]} #{$peg[$code[2]]} #{$peg[$code[3]]} ]"
end

def player_get_choice
  puts "\nPlay as Code Breaker or Code Maker?"
  puts "Press a key: [1: Maker] [2: Breaker]"
  
  player_choice = gets.chomp
  
  if player_choice == '1' || player_choice == "" || player_choice == " "
    puts "You choose Code Maker."
    $human = Code_Maker.new("human")
    $computer = Code_Breaker.new("computer")
    $player = {maker: $human, breaker: $computer}
  elsif player_choice == '2'
    puts "You choose Code Breaker."
    $human = Code_Breaker.new("human")
    $computer = Code_Maker.new("computer")
    $player = {maker: $computer, breaker: $human}
  else
    puts "\nInvalid key, please try again."
    player_get_choice
  end
end

def player_set_turns
  loop do
    puts "\nHow many guesses? 6, 8, 10 or 12 (default)."
    puts "Choose an option or press space/enter to leave the default:"
    choice = gets.chomp

    if choice == " " || choice == ""
      $number_of_turns = 12
      break
    elsif choice != '6' && choice != '8' && choice != '10' && choice != '12'
      puts "\nInvalid input, please try again"
    else
      $number_of_turns = choice.to_i
      break
    end
  end
  build_game_array
end

def build_game_array
  row = "[ ___ ___ ___ ___ ]"
  $number_of_turns.times do
    $game_array << row
  end
end