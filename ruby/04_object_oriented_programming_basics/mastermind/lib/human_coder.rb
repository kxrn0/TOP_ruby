# frozen-string-literal: true

require_relative 'coder'

# Flesh coder
class HumanCoder < Coder
  attr_accessor :code

  def reset_code
    @code = ''

    puts "Enter a #{Coder::CODE_SIZE} letter code with the characters in #{Coder::PEGS}."

    done = false
    until done
      done = valid_code
      puts 'Please enter a valid code!' unless done
    end
  end

  private

  def valid_code
    print '> '
    input = gets.chomp.downcase
    is_valid = input =~ /^[abcdef]{4}$/

    @code = input if is_valid

    is_valid
  end
end
