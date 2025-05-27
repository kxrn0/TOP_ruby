# frozen-string-literal: true

# Class used for formatting and printing things to the console
class Printer
  HELP_MESSAGE = <<~HEREDOC
    Help:
      h             - show help menu
      b             - show board
      s             - show current scores
      c             - toggle cell numbers
      r             - restart game
      k             - reset everything
      e             - terminate program
      <cell_number> - choose a cell
  HEREDOC

  def initialize(game)
    @game = game
  end

  def print_help
    puts "\n#{HELP_MESSAGE}"
  end

  def print_welcome_message
    puts 'TIC TAC TOE'
    puts "copyright @kxrn0, 1985\n\n"
    puts 'The game will use naughts (o), and crosses (x) for the markers.'
  end

  def print_scores
    scores = format_scores

    puts "ROUND #{@game.round.number}"
    puts 'WINS:'
    puts scores
  end

  def create_order_message(naughts_name, crosses_name)
    <<~HEREDOC
      Who will go first?
        (a) - o 「#{naughts_name}」
        (b) - x 「#{crosses_name}」
        (c) - random
      Enter a, b, or c >#{' '}
    HEREDOC
  end

  def deep_sleep
    puts "\nThe game is loading, please wait warmly...\n"
    sleep 1
  end

  private

  def order_results(players, formatted)
    first  = nil
    second = nil

    if players[0].name == formatted[:long][:player].name
      first = formatted[:long][:string]
      second = formatted[:short][:string]
    else
      first = formatted[:short][:string]
      second = formatted[:long][:string]
    end

    [first, second]
  end

  def format_name(player, spaces)
    "「#{player.name} (#{player.marker})」#{' ' * spaces}: #{player.wins}"
  end

  def compute_diff(players)
    players[:long].name.size - players[:short].name.size
  end

  def format_names(players)
    results = {
      long: { player: players[:long], string: '' },
      short: { player: players[:short], string: '' }
    }

    diff = compute_diff players

    results[:long][:string] = format_name players[:long], 0
    results[:short][:string] = format_name players[:short], diff

    results
  end

  def sort_by_names(players)
    results = {}

    if players[0].name.size > players[1].name.size
      results[:long] = players[0]
      results[:short] = players[1]
    else
      results[:long] = players[1]
      results[:short] = players[0]
    end

    results
  end

  def format_scores
    sort_results = sort_by_names @game.players
    format_results = format_names sort_results
    first, second = order_results @game.players, format_results

    "\t#{first}\n\t#{second}\n"
  end
end
