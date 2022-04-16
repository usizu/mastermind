# Classes
# ======================================================

module Codes
  def code_generate_choice(type = 'guess')
    puts "\n"
    puts "Choose your #{type}:"
    puts "=================\n"

    code_finished = false
    chosen_code = []

    until code_finished == true
      loop do
        puts "\nCurrent #{type}: #{display_code(chosen_code)}"

        if chosen_code.length == 4
          puts "\nConfirm this is your final #{type}? y/n"
          confirm = gets.chomp
          if confirm.downcase == 'y' || confirm == ""
            code_finished = true
            break
          else
            chosen_code.pop
            next
          end
        end

        puts "Type a number to choose a peg. [Pegs: #{display_peg_colour_numbers}]"
        puts "Press x to remove a peg."
        choice = gets.chomp

        if $peg.has_key?(choice.to_i)
          chosen_code << choice.to_i
          break
        elsif choice == "x"
          chosen_code.pop
          break
        else
          puts "\nInvalid character, try again:"
        end
      end

    end

    return chosen_code
  end

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

  def bg_black;       "\e[40m#{self.gray}\e[0m" end
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

class Code_Maker

  include Codes

  attr_reader :type, :feedback_pegs

  def initialize(type)
    @type = type
  end

  def make_code
    puts "Making code..."
    if @type == "computer"
      $code = code_generate_randomly
      puts "The Code: #{display_code}"
    elsif @type == "you"
      $code = code_generate_choice('Code')
      puts "Your Code: #{display_code}"
    end
  end

  def set_pegs
    # you:
      # tells you how many pegs of each colour to put
      # saves these in an array
      # prompts you to set them out
        # can they be set in any order?
      # each one you put, pops one off the array
      # method ends when array is empty
      # then a method shows the pegs on the board
    # computer:
      # counts the correct pegs to do, then does them

    # peg rules:
      # 2 kinds of peg: black and white
      # 1 black peg for correct colour+position
      # 1 white peg for correct colour in wrong position
      # pegs are given for each correct guess

    # check_pegs method
    #  returns how many pegs of each type should be set
    check_pegs
    puts "Peg check: #{display_code(@feedback_pegs)}"
  end

  def check_pegs
    @feedback_pegs = []
    @guess = $player[:breaker].guess

    # black pegs
    @guess.each_with_index do |colour, position|
      puts "colour: #{colour} | pos: #{position}"
      if $code[position] == colour
        puts "match (#{position})"
        @feedback_pegs << :black
      end
    end

    # white pegs
    uniques = $code.uniq
    @guess.each do |colour|
      count_colour = $code.count(colour)
      count_black  = @feedback_pegs.count(colour)

      # compare count of black pegs and colour == white pegs.
      if count_colour - count_black > 0
        @feedback_pegs << :white
      end
    end
  end

end

class Code_Breaker

  include Codes

  attr_reader :type, :guess 

  def initialize(type)
    @type = type
  end

  def guess_code
    if @type == "computer"
      code_guess_randomly
    elsif @type == "you"
      code_guess_choice
    end
  end

  def code_guess_randomly
    # musn't be the same as a previous guess.
    # so save each guess into a previous_guesses array, and compare the new one.
    @guess = code_generate_randomly
  end

  def code_guess_choice
    @guess = code_generate_choice
  end

end
