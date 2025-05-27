# frozen-string-literal: true

# Player class
class Player
  attr_reader :name, :wins, :marker

  def initialize(name, wins, marker)
    @name = name
    @wins = wins
    @marker = marker
  end
end

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

def format_scores(players)
  sort_results = sort_by_names players
  format_results = format_names sort_results
  first, second = order_results players, format_results

  "#{first}\n#{second}"
end

player1 = Player.new 'alice', 4, 'o'
player2 = Player.new 'bob', 1, 'x'

puts format_scores [player1, player2]
