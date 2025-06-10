# frozen-string-literal: true

require_relative 'coder'

# Automatic coder
class AICoder < Coder
  def reset_code
    @code = ''

    Coder::CODE_SIZE.times { @code += Coder::PEGS.sample }
  end
end
