require_relative "get_moves"

def find_path(cell, target, size)
  paths = [[cell]]

  loop do
    temps = []

    paths.each do |path|
      moves = get_moves(path[-1], size)
        .select { |move| !path.include? move }
      found = moves.find { |other| other == target }

      if found
        return path + [found]
      end

      moves.map! { |move| path + [move] }
      temps += moves
    end

    paths = temps
  end
end
