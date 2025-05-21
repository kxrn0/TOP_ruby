# frozen-string-literal: true

# This is a class
class Here
  def print_thing(naughts, crosses)
    message = <<~HEREDOC
      Who will go first?
        (a) - 「#{naughts}」
        (b) - 「#{crosses}」
    HEREDOC

    puts message
  end
end

instance = Here.new

instance.print_thing 'player one', 'player two'
