# Methods

def welcome_message
  puts "\n"
  puts "Welcome to Mastermind"
  puts "=====================\n"
  puts $rules
end

def code_generate
  $code = []
  4.times do
    $code << [1,2,3,4,5,6].sample
  end
  return $code
end

def code_display
  code_string = ""

  $code.each do |x|
    string = " #{x.to_s} "
    case x
    when 1
      code_string << string.bg_red << " "
    when 2
      code_string << string.bg_green << " "
    when 3
      code_string << string.bg_brown << " "
    when 4
      code_string << string.bg_blue << " "
    when 5
      code_string << string.bg_magenta << " "
    when 6
      code_string << string.bg_cyan << " "
    end
  end

  puts "Code: #{code_string}"
end

def player_get_choice
  puts "\nPlay as Code Breaker or Code Maker?"
  puts "Press a key: [1: Maker] [2: Breaker]"
  
  player_choice = gets.chomp.to_i
  
  if player_choice == 1
    puts "You choose Code Maker."
    $you = Code_Maker.new("player")
    $computer = Code_Breaker.new("computer")
    $player = {maker: $you, breaker: $computer}
  elsif player_choice == 2
    puts "You choose Code Breaker."
    $you = Code_Breaker.new("player")
    $computer = Code_Maker.new("computer")
    $player = {maker: $computer, breaker: $you}
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
      $guesses = 12
      break
    elsif choice != '6' && choice != '8' && choice != '10' && choice != '12'
      puts "\nInvalid input, please try again"
    else
      $guesses = choice.to_i
      break
    end
  end
end