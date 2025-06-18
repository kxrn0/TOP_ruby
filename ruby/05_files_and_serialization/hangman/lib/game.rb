# frozen_string_literal: true

require_relative 'coder'
require_relative 'player'
require_relative 'file_manager'
require_relative 'input_handler'

# Hangman game
class Game
  attr_reader :player, :coder, :file_manager

  HELP = <<~HEREDOC

    H E L P:
      !n      - New Game!
      !s      - Show Saved Games!
      !l <\\d> - Load Saved Game!
      !d <\\d> - Delete Saved Game!
      !c      - Save Current Game!
      !h      - Print Help Menu!
      !e      - Terminate Program! (not recommended)
    #{'  '}
  HEREDOC

  INTRO = <<~HEREDOC
    The Amazing
    H A N G M A N
    copyright @kxrn0, 1976

  HEREDOC

  def initialize
    @input_handler = nil
    @file_manager = nil
    @player = nil
    @coder = nil
    @running = true
    @gaming = true
    @terminated = false
  end

  def play
    print_welcome_message

    while @running
      reset
      game_loop

      @running = play_again? unless @terminated
    end
  end

  def to_h
    { coder: @coder.to_h, player: @player.to_h }
  end

  def load_data(game_data)
    if game_data.nil?
      puts 'Please enter a valid index'
    else
      @player.hydrate game_data['player']
      @coder.hydrate game_data['coder']
    end
  end

  def make(move)
    hit = @coder.guess move

    game_over true if @coder.guessed?

    @player.lives -= 1 unless hit

    return unless @player.lives.zero?

    game_over false
  end

  def new_game
    prompt = 'Discard current game and start new one (yes / no)? > '
    @input_handler.answer_yes_no prompt

    print_welcome_message
    reset
  end

  def terminate
    @terminated = true
    @gaming = false
    @running = false
  end

  private

  def print_welcome_message
    puts INTRO
    puts HELP
  end

  def play_again?
    @input_handler.answer_yes_no 'Play again (yes / no) > '
  end

  def game_over(won)
    state = won ? 'WON' : 'LOST!'

    puts "GAME OVER! YOU #{state}"

    puts "The secret word was #{@coder.secret}!" unless won

    @gaming = false
  end

  def game_loop
    @input_handler.handle_input while @gaming
  end

  def reset
    @input_handler = InputHandler.new self
    @file_manager = FileManager.new
    @player = Player.new
    @coder = Coder.new self
    @gaming = true
  end
end
