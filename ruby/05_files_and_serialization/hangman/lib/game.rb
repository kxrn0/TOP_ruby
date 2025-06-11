# frozen_string_literal: true

# Hangman game
class Game
  attr_reader :player, :coder

  HELP = <<~HEREDOC
    H E L P:
      !n      - New Game!
      !s      - Show Saved Games!
      !l <\d> - Load Saved Game!
      !d <\d> - Delete Saved Game!
      !c      - Save Current Game!
      !h      - Print Help Menu!
      !e      - Terminate Program! (not recommended)
  HEREDOC

  INTRO = <<~HEREDOC
    The Amazing
    H A N G M A N
    copyright @kxrn0, 1976
  HEREDOC

  def initialize
    @player = nil
    @coder = nil
    @input_handler = nil
    @file_manager = nil
    @running = true
    @gaming = true
    @terminated = false
  end

  def play
    puts INTRO
    puts HELP

    while @running
      reset
      game_loop

      @running = play_again? unless @terminated
    end
  end

  private

  def play_again?
    false
  end

  def game_loop
    @input_handler.handle_input while @gaming
  end

  def reset
    @player = Player.new
    @coder = Coder.new self
    @input_handler = InputHandler.new self
    @file_manager = FileManager.new
    @gaming = true
  end
end
