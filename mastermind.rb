# Mastermind

# [x] method to randomly generate the four colour code
# [x] method to display it
# [x] choose to be a code-maker or a code-breaker
# [x] method to ask for the number of turns

# [ ] put classes into their own file and import them
# [ ] method to check if the guess matches the code
# [ ] method to print out your guesses with colours
# [ ] method to decide how many rounds to play, must be even number
# [ ] method to let code-maker set 4 colours, delete them, edit, etc

# 3 difficulty settings for computer: easy (random) mid/high based on an algorithm

# config: blanks allowed? duplicates allowed?

# gameloop where code-breaker tries to guess the pattern

# Vars
rules = "
One player is the code-maker and the other is the code-breaker. The code-maker sets
a code of four code pegs, from a set of six colours. The code-breaker has to guess
the correct sequence of code pegs."

# Methods
# ======================================================

def welcome_message
  puts "\n"
  puts "Welcome to Mastermind"
  puts "=====================\n"
  puts rules
end

class String
  # Taken from a comment:
  # https://stackoverflow.com/questions/1489183/how-can-i-use-ruby-to-colorize-the-text-output-to-a-terminal
  
  def black;          "\e[30m#{self}\e[0m" end
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def brown;          "\e[33m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  def magenta;        "\e[35m#{self}\e[0m" end
  def cyan;           "\e[36m#{self}\e[0m" end
  def gray;           "\e[37m#{self}\e[0m" end

  def bg_black;       "\e[40m#{self.black}\e[0m" end
  def bg_red;         "\e[41m#{self.black}\e[0m" end
  def bg_green;       "\e[42m#{self.black}\e[0m" end
  def bg_brown;       "\e[43m#{self.black}\e[0m" end
  def bg_blue;        "\e[44m#{self.black}\e[0m" end
  def bg_magenta;     "\e[45m#{self.black}\e[0m" end
  def bg_cyan;        "\e[46m#{self.black}\e[0m" end
  def bg_gray;        "\e[47m#{self.black}\e[0m" end

  def bold;           "\e[1m#{self}\e[22m" end
  def italic;         "\e[3m#{self}\e[23m" end
  def underline;      "\e[4m#{self}\e[24m" end
  def blink;          "\e[5m#{self}\e[25m" end
  def reverse_color;  "\e[7m#{self}\e[27m" end
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
    $player = Code_Maker.new("player")
  elsif player_choice == 2
    puts "You choose Code Breaker."
    $player = Code_Breaker.new("computer")
  else
    puts "\nInvalid key, please try again."
    player_get_choice
  end
end

class Code_Maker
  def initialize(type)
    @type = type
  end

  # some methods are the same if its computer or human,
  # some are inherited conditionally depending...
end

class Code_Breaker
  def initialize(type)
    @type = type
  end
end

def player_get_turns
  puts "\nHow many guesses? 6, 8, 10 or 12."
  puts "Default is 12."
  puts "Choose an option or press space to leave the default:"
  choice = gets.chomp
  if choice != 6 || choice != 8 || choice != 10 || choice != 12
    puts "\nInvalid input, please try again"
    player_get_turns
  elsif choice == " "
    $guesses = 12
  else
    $guesses = choice.to_i
  end

  puts "You chose: #{$guesses} guesses."
end


# Game Logic
welcome_message

# Ask player to be Breaker or Maker
player_get_choice

# Ask how many turns the game will last
player_get_turns

# Start game loop as your role