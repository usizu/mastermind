# Classes
# ======================================================

module Codes

  def code_generate_choice(type = 'guess')
    puts "\n"
    puts "Choose your #{type}:"
    puts "=================\n"

    code_input = []
    code_finished = false

    until code_finished == true
      loop do

        puts "\nCurrent #{type}: #{display_code(code_input)}"

        # Confirm Final Code?
        if code_input.length == 4
          puts "\nConfirm final #{type}? y/n"
          confirm = gets.chomp
          if confirm.downcase == 'y' || confirm == ""
            code_finished = true
            break
          else
            code_input.pop
            next
          end
        end

        # Add or Remove pegs
        puts "Type your inputs: [Pegs: #{display_pegs}]"
        puts "Press x to remove a peg."
        choice = gets.chomp.chars.first(4) # cut it to 4 digits

        if choice == ["x"] then code_input.pop; break; end

        # keep only peg key inputs
        choice.map! {|x| x.to_i if $peg_keys.include?(x.to_i) }.delete(nil)

        # save input
        code_input = (code_input += choice).first(4) # constrain to 4 characters
      end

    end

    return code_input
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
    if @type == "computer"
      $code = code_generate_randomly
      puts "The Code: #{display_code}"
    elsif @type == "you"
      $code = code_generate_choice('Code')
      puts "Your Code: #{display_code}"
    end
  end

  def set_pegs
    # check_pegs method
    #  returns how many pegs of each type should be set
    check_pegs
  end

  def check_pegs
    @guess = $player[:breaker].guess
    @code_copy = $code.clone
    @feedback_pegs = []

    # black pegs check...
    @guess.each_with_index do |colour, position|
      if @code_copy[position] == colour
        @feedback_pegs << :black
        @code_copy[position] = nil
      end
    end

    # white pegs check...
    @guess.each_with_index do |colour, position|
      if @code_copy.include?(colour)
        @feedback_pegs << :white
        @code_copy[position] = nil
      end
    end

    @feedback_pegs.shuffle! # shuffle because peg position is arbitrary
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
