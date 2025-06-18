# frozen-string-literal: true

require 'json'

# Manages file operations
class FileManager
  def select_random_word
    lines = []

    File.readlines('./lib/dictionary.txt').each do |line|
      str = line.chomp
      lines.push str unless str == ''
    end

    lines.sample
  end

  def show_games
    puts 'Saved Games:'
    games = sort_by_date make_games_list
    games.each_with_index do |game, index|
      position = index + 1
      name = format_name game

      puts "(#{position}) - #{name}"
    end
  end

  def save_game(data_hash)
    namefile = data_hash[:name].split(' ').join '_'
    filename = "#{namefile}-#{data_hash[:created_at]}.json"
    data = JSON.dump data_hash

    Dir.mkdir 'games' unless Dir.exist? 'games'

    File.open("./games/#{filename}", 'w') do |file|
      file.puts data
    end

    puts "Game saved as #{filename}!\n"
  end

  def delete_game(position)
    index = position - 1
    game = load_game index

    raise 'fuck!' if game.nil?

    name = game[:filename]

    File.delete name

    name
  end

  def load_game_at(position)
    index = position - 1
    game = load_game index

    if game.nil?
      nil
    else
      game[:contents]
    end
  end

  private

  def load_game(index)
    return nil if index.negative?

    games = sort_by_date make_games_list

    return nil if index >= games.size

    games[index]
  end

  def parse(entry)
    contents = File.read entry

    {
      filename: entry,
      contents: JSON.parse(contents)
    }
  end

  def valid?(file)
    file.split('.')[-1] == 'json'
  end

  def format_name(game)
    date = Time
           .at(game[:contents]['created_at'])
           .to_s
           .split(' ')[0..1]
           .join ' '

    "#{game[:contents]['name']} - #{date}"
  end

  def sort_by_date(games)
    games.sort! do |a, b|
      b[:contents]['created_at'] -
        a[:contents]['created_at']
    end
  end

  def make_games_list
    Dir.mkdir 'games' unless Dir.exist? 'games'

    games = []

    Dir.entries('games').each do |entry|
      games.push(parse("./games/#{entry}")) if valid? entry
    end

    games
  end
end
