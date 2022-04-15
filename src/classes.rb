# Classes
# ======================================================

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

# [] game_array should be of length of number_of_turns
# [] print game_array to show how many turns are left

# [] generate random guess
# [] check guess with code
# [] generate black/white peg feedback
# [] each turn, the guesses and feedback are added to a
#   parent array, and displayed in sequence

class Code_Maker
  def initialize(type)
    @type = type
  end

  def make_code
    puts "Making code..."
    if @type == "computer"
      code_generate_randomly
      puts "The Code: #{display_code}"
    elsif @type == "human"
      code_generate_choice
      puts "Your Code: #{display_code}"
    end
  end

  def code_generate_randomly
    4.times { $code << Random.new.rand(1..6) }
  end

  def code_generate_choice
    puts "\n"
    puts "Choose your code:"
    puts "=================\n"

    code_finished = false
    
    until code_finished == true
      loop do
        puts "\nCurrent Code: #{display_code}"

        if $code.length == 4
          puts "\nConfirm this is your final code? y/n"
          confirm = gets.chomp
          if confirm.downcase == 'y' || confirm == ""
            code_finished = true
            break
          else
            $code.pop
            next
          end
        end

        puts "Type a number to choose a peg. [Pegs: #{display_peg_colour_numbers}]"
        puts "Press x to remove a peg."
        choice = gets.chomp

        if $peg.has_key?(choice.to_i)
          $code << choice.to_i
          break
        elsif choice == "x"
          $code.pop
          break
        else
          puts "\nInvalid character, try again:"
        end
      end

    end
  end

end

class Code_Breaker

  attr_reader :guess

  def initialize(type)
    @type = type
  end

  def guess_code
    if @type == "computer"
      code_guess_randomly
    elsif @type == "human"
      code_guess_choice
    end
  end

  def code_guess_randomly
    @guess = [1,2,3,4]
  end

  def code_guess_choice

  end

end