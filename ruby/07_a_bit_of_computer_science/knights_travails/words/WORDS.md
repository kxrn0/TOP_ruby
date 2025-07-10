# Knights Travails

The board is a graph, the squares are the vertices, and the moves are the edges. The graph is undirected, since if you can go from square A to B, you can use that same edge to go from B to A.

The instructions warn that an algoritm could lead to an infinite loop. Given that the graph is undirected I can kind of see both algorithms leading to that, but I'll have to think harder about this.

I'm trying to find the shortest path from one cell to another. First of all, how do I keep track of where I've been? That may actually be also how I'll do this. I keep track of an array of the places I've been to, and only add new ones if they are not in the array. Would I ever need to visit the same place twice if I'm looking for the shortest path? Why would I? I don't think I need, and that's what I'll assume for now.

So I get a cell, find its neighbors, and for each one try to find the path from each one of them to the target cell, something like

```
find_path_helper(path, target) {
  tail = path.at -1
  neighbors = find_neighbors tail
  paths = neighbors.fap n => path.include?(n) == false, n => [...path, n]

  // rest of the fucking...
}

find_path(start, end) {
  find_path_helper [start], end
}
```

where `fap` is a filter map method, and I'm assuming `include?` works in mysterious ways that make it so that it returns true if two neighbor objects describe the same position. There's a reason it's called "pseudocode". Thus, I have zero or more arrays with the elements of `path`, and a neighbor at the end.

I start at some given cell. I find all its neighbors, then find the paths through the neighbors and return the shortest one. Finding the path through a neighbor means making a new path, `[...path, neighbor]`, then feeding this into `find_path_helper`, so I find all neighbors of `neighbor`, and find the shortest path through a neighbor. If I'll be recursing, when do I stop? Once there are no more neighbors, or if one of the neighbors is the target. If there are no more neighbors I return the given path. If one of the neighbors is the target I return the given path with the target appended to it.

```
find_free_neighbors(path, cell) {
  // left
  lu = new Cell cell.x - 2, cell.y + 1
  ld = new Cell cell.x - 2, cell.y - 1

  //right
  ru = new Cell cell.x + 2, cell.y + 1
  rd = new Cell cell.x + 2, cell.y - 1

  //up
  ul = new Cell cell.x - 1, cell.y + 2
  ur = new Cell cell.x + 1, cell.y + 2

  //down
  dl = new Cell cell.x - 1, cell.y - 2
  dr = new Cell cell.x + 1, cell.y - 2

  cells = [lu, ld, ru, rd, ul, ur, dl, dr]
    .filter c => {
      inside = c.x.between?(0, 7) && c.y.between?(0, 7)

      return false unless inside

      path.include? c ? false : true
    }
}

find_shortest(list) {
  shortest = list[0]

  list.each item =>
    shortest = item if item.size < shortest.size

  shortest
}

find_path(path, target) {
  tail = path.last
  neighbors = find_free_neighbors path, tail

  return path if neighbors.empty?

  found = neighbors.find n => n == target

  return [...path, found] unless found.null?

  paths = neighbors.map n => find_path([...path, n], target)

  find_shortest paths
}

knight_moves(start, end) {
  find_path [start], end
}
```

I assumed there would be a `Cell` class, but the instructions seem to assume a cell would be represented as an array with two elements. I'd very much like to deviate from the instructions and have a dedicated `Cell` class, but I'll concede.

## Fuck

Looks like I forgot how blocks work. This function

```ruby
def find_valid_cells(path, cells)
  cells.filter do |cell|
    x, y = cell
    inside = x.between?(0, 7) && y.between?(0, 7)

    return false unless inside

    visited = path.any? { |c| cequal c, cell }

    visited ? false : true
  end
end
```

doesn't work the way I expected it to. Blocks return from the context where they are created, so the early return returns `true` from `find_valid_cells`. This discourages writting long anonymous functions which helps with keeping functions short.

I moved the code in the block in `find_valid_cells` to a function. It doesn't work. It enters an infinite loop.

```ruby
def find_shortest(list)
  shortest = list[0]

  list.each do |item|
    shortest = item if item.size < shortest.size
  end

  shortest
end

def cequal(cell1, cell2)
  cell1[0] == cell2[0] && cell1[1] == cell2[1]
end

def valid_cell?(path, cell)
  x, y = cell
  inside = x.between?(0, 7) && y.between?(0, 7)

  return false unless inside

  visited = path.any? { |other| cequal other, cell }

  visited ? false : true
end

def find_valid_cells(path, cells)
  cells.filter { |cell| valid_cell? path, cell }
end

def find_free_neighbors(path, cell)
  x, y = cell

  # left
  lu = [x - 2, y + 1]
  ld = [x - 2, y - 1]

  # right
  ru = [x + 2, y + 1]
  rd = [x + 2, y - 1]

  # up
  ul = [x - 1, y + 2]
  ur = [x + 1, y + 2]

  # down
  dl = [x - 1, y - 2]
  dr = [x + 1, y - 2]

  cells = [lu, ld, ru, rd, ul, ur, dl, dr]

  find_valid_cells path, cells
end

def find_path(path, target)
  tail = path.last
  neighbors = find_free_neighbors path, tail

  return path if neighbors.empty?

  found = neighbors.any? { |cell| cequal cell, target }

  return [*path, target] if found

  paths = neighbors.map { |neigh| find_path [*path, neigh], target }

  find_shortest paths
end

def knight_moves(from, to)
  find_path [from], to
end
```

I assumed I was kind of doing breadth first search, but maybe that's not the case.

According to the wikipedia article on breadth first search, one of the applications of the algorithm is

> Finding the shortest path between two nodes u and v, with path length measured by number of edges (an advantage over depth-first search)

so I'll assume bfs is the correct algorithm until proven otherwise.

I don't think I'm using bfs correctly. First I find all the neighbors of a cell, take one, find all neighbors of it, and so on, it looks more like dfs.

How do I properly implement bfs? bfs works with a queue. So I'm in a cell, I find all the neighbors of the current cell, and add them to the queue, then dequeue them in the order they were added, while enqueueing their neighbors. I can't quite do that since one of the neighbors is the initial cell, so I'd be entering an infinite loop. I need to keep track of which cells have been visited by a given path, that may also help knowing which path to take once the target cell is found.

The current node should know where it comes from, or rather, which of its neighbors enqueued it. Should the objects being enqueued be something that has a reference to the thing that enqueued it? something like

```
item = {
  parent: otherItem,
  cell: [x, y]
}
```

but what if we have A -> B -> ... -> C, and A hapens to be one of C's neighbors? Checking we don't enqueue only the parent isn't enough.

## Cheating

Sadly I've already wasted too much time on this, and I need to move on. After googling "knight shortest path" I found [a solution in C#](https://techintblog.blogspot.com/2016/08/question-have-chess-board-and-are-given.html).

```c#
/// <summary>
/// Class to keep track of the cells in the chess board.
/// </summary>
public class Cell:IComparable<Cell>
{
    public int Row { get; set;}

    public int Column { get; set; }

    public Cell Parent { get; set; }

    public int CompareTo(Cell other)
    {
        var otherCell = (Cell)other;
        return (this.Row == otherCell.Row && this.Column == otherCell.Column) ? 0 : 1;
    }

    public override int GetHashCode()
    {
        var key = Row.ToString() + Column.ToString();
        return key.GetHashCode();
    }

    public override bool Equals(object obj)
    {
        var other = obj as Cell;
        return (other != null) && (other.Row == this.Row) && (other.Column == this.Column);
    }
}

/// <summary>
/// Class that has implementation of the logic to move the knight
/// </summary>
public class MoveKnight
{
    public static void Test()
    {
        var src = new Cell() { Row = 4, Column = 5 };
        var dest = new Cell() { Row = 0, Column = 0 };
        var instance = new MoveKnight();
        var result = instance.Move(src, dest);
    }

    /// <summary>
    /// Method that performs the BST and returns one of the shortest paths
    /// for the knight to move from source to destination
    /// </summary>
    /// <param name="source"></param>
    /// <param name="dest"></param>
    /// <returns></returns>
    public List<Cell> Move(Cell source, Cell dest)
    {
        var dict = new Dictionary<Cell, bool>();
        List<Cell> rtnList = null;
        var queue = new Queue<Cell>();
        queue.Enqueue(source);
        dict.Add(source, true);

        while(queue.Count != 0)
        {
            var cell = queue.Dequeue();
            if (cell.Row == dest.Row && cell.Column == dest.Column)
            {
                rtnList = GetList(cell, dict);
                break;
            }

            var moves = GetMoves(cell, dict);
            AddItemsToQueue(queue, moves, cell);
        }

        return rtnList;
    }

    /// <summary>
    /// Returns the list of cells from the dest to the source by backtracking
    /// </summary>
    /// <param name="dest"></param>
    /// <param name="dict"></param>
    /// <returns></returns>
    private List<Cell> GetList(Cell dest, Dictionary<Cell, bool> dict)
    {
        var rtnList = new List<Cell>();
        var parent = dest.Parent;
        rtnList.Add(dest);
        while (parent != null)
        {
            rtnList.Add(parent);
            parent = parent.Parent;
        }
        return rtnList;
    }

    /// <summary>
    /// Adds cells to the queue for BST, this also keeps track of the parent for back tracking
    /// </summary>
    /// <param name="queue"></param>
    /// <param name="list"></param>
    /// <param name="parent"></param>
    private void AddItemsToQueue(Queue<Cell> queue, List<Cell> list, Cell parent)
    {
        foreach (var cell in list)
        {
            cell.Parent = parent;
            queue.Enqueue(cell);
        }
    }

    /// <summary>
    /// Given a source cell and a dictionary of visited cells,
    /// returns that list of cells that the knight can move to.
    /// </summary>
    /// <param name="source"></param>
    /// <param name="dict"></param>
    /// <returns></returns>
    private List<Cell> GetMoves(Cell source, Dictionary<Cell, bool> dict)
    {
        var rtnValue = new List<Cell>();
        Cell cell = null;
        // top left
        var row = source.Row - 2;
        var col = source.Column - 1;
        cell = new Cell { Row = row, Column = col };
        if (IsValid(row) && IsValid(col) && !dict.ContainsKey(cell))
        {
            rtnValue.Add(cell);
            dict.Add(cell, true);
        }

        // top right
        row = source.Row - 2;
        col = source.Column + 1;
        cell = new Cell { Row = row, Column = col };
        if (IsValid(row) && IsValid(col) && !dict.ContainsKey(cell))
        {
            rtnValue.Add(cell);
            dict.Add(cell, true);
        }

        // left top
        row = source.Row - 1;
        col = source.Column - 2;
        cell = new Cell { Row = row, Column = col };
        if (IsValid(row) && IsValid(col) && !dict.ContainsKey(cell))
        {
            rtnValue.Add(cell);
            dict.Add(cell, true);
        }

        // left bottom
        row = source.Row + 1;
        col = source.Column - 2;
        cell = new Cell { Row = row, Column = col };
        if (IsValid(row) && IsValid(col) && !dict.ContainsKey(cell))
        {
            rtnValue.Add(cell);
            dict.Add(cell, true);
        }

        // right top
        row = source.Row - 1;
        col = source.Column + 2;
        cell = new Cell { Row = row, Column = col };
        if (IsValid(row) && IsValid(col) && !dict.ContainsKey(cell))
        {
            rtnValue.Add(cell);
            dict.Add(cell, true);
        }

        // right bottom
        row = source.Row + 1;
        col = source.Column + 2;
        cell = new Cell { Row = row, Column = col };
        if (IsValid(row) && IsValid(col) && !dict.ContainsKey(cell))
        {
            rtnValue.Add(cell);
            dict.Add(cell, true);
        }

        // bottom left
        row = source.Row + 2;
        col = source.Column - 1;
        cell = new Cell { Row = row, Column = col };
        if (IsValid(row) && IsValid(col) && !dict.ContainsKey(cell))
        {
            rtnValue.Add(cell);
            dict.Add(cell, true);
        }

        // bottom right
        row = source.Row + 2;
        col = source.Column + 1;
        cell = new Cell { Row = row, Column = col };
        if (IsValid(row) && IsValid(col) && !dict.ContainsKey(cell))
        {
            rtnValue.Add(cell);
            dict.Add(cell, true);
        }
        return rtnValue;
    }

    /// <summary>
    /// Checks whether a given a given index is valid on the chess board
    /// </summary>
    /// <param name="rowCol">Input index</param>
    /// <returns></returns>
    private bool IsValid(int rowCol)
    {
        if (rowCol >= 0 && rowCol <=7)
        {
            return true;
        }

        return false;
    }

}
```

### `Cell`

Like the description says, it represents a cell in the chessboard. A `Cell` object has `Row` and `Column` properties that indicate where in the board it is. It also has a parent, which is likely the cell that enqueued it.

The `Cell` object has three methods; `CompareTo`, `GetHashCode`. and `Equals`.

`CompareTo` returns 1 if the given parameter is another cell with the same position as the caller, 0 otherwise, which is weird since 0 usually represents false, and 1 true, not the other way around. There must be a good reason for this, specially since `Equals` also compares in the same way, but returns a boolean. The output of `CompareTo` is probably used in a computation.

### `MoveKnight`

A wrapper around some logic. I've heard that everything in java has to be wrapped in a class, so it's probably not that important.

### `Test`

A test that works in mysterious ways.

### `GetMoves`

It goes to each reachable square, checks if it's inside the board, and not already visited, and adds it to the list of return values. The `dict` parameter it takes in is the set of visited cells. If a cell is inside the board, and not in the `dict` already, it is pushed to the `dict`.

How does `dict.ContainsKey(cell)` work? `dict` is a `Dictionary`, which is kind of like a `Map` in javaScript, or a regular hash in ruby. Kind of, because something feels off. Assume we get a valid `cell`, which is not in `dict` already. We push it into `dict`, and move on. Later when calling `GetMoves` again we again land on this cell. The newly created `cell` object is different from the one created in the previous call, that is, assuming that object identity works like in javaScript or ruby, so it doesn't matter that both `cell` objects have the same `Row` and `Column` properties, they are different objects, so this should be a bug, unless... unless the way a `Dictionary` stores a value is by getting the key of the hash with `GetHashCode`, which is overriden and made a function of the `Row` and `Column` values. That makes sense, and I'll assume that's what's happening.

I want to stay consistent with the instructions, so I want to use arrays instead of specialized classes. I may be able to use a `Set` instead of a dictionary like object, and it looks like doing `[1, 2].to_s` is enough to achieve the same effect.

Still, rubocop will yell at me about too many branches or whatever, so I think I'll do it like this

```ruby
def valid_cell?(cell, visited)
  cell.x.between?(0, 7) && cell.y.between?(0, 7) && visited.include?(cell.to_s) == false
end

def check_cell(cell, visited, neighbors)
  return unless valid_cell? cell, visited

  neighbors.push cell
  visited.add cell
end

def find_free_neighbors(source, visited)
  dx = [-2, -2, 2, 2, -1, 1, -1, 1]
  dy = [1, -1, 1, -1, 2, 2, -2, -2]
  x, y = source
  neighbors = []

  dx.size.times do |idx|
    check_cell [x + dx[idx], y + dy[idx]], visited, neighbors
  end

  neighbors
end
```

that's still not quite right. There's still the parent thing. I just want to be able to input and output arrays, but it doesn't matter what I do in between, so I can do

```
knight_travels(from, to) {
  from = Cell.from_a from
  to = Cell.from_a to

  // rest of the fucking...

  path.map cell => cell.to_a
}
```

Thus, there's a `Cell` class

```ruby
class Cell
  attr_accessor :parent
  attr_reader :x, :y

  def self.from_a(rray)
    Cell.new rray[0], rray[1]
  end

  def initialize(col, row)
    @x = col
    @y = row
    @parent = nil
  end

  def to_s
    "#{@x},#{@y}"
  end
end
```

then the only change is in

```ruby
def find_free_neighbors(source, visited)
  dx = [-2, -2, 2, 2, -1, 1, -1, 1]
  dy = [1, -1, 1, -1, 2, 2, -2, -2]
  x, y = source
  neighbors = []

  dx.size.times do |idx|
    cell = Cell.new x + dx[idx], y + dy[idx]
    check_cell cell, visited, neighbors
  end

  neighbors
end
```

### `GetList`

Why is there a dictionary in the parameter list if it isn't used? it doesn't matter. It just does backtracking on a linked list to get the path.

### `AddItemsToQueue`

It adds the items to the queue while parenting them.

### `Move`

It seems simple to implement

```ruby
def knight_travels(from, to)
  from = Cell.from_a from
  to = Cell.from_a to
  visited = Set.new
  queue = Queue.new

  queue.enqueue from
  visited.add from.to_s

  until queue.empty?
    cell = queue.dequeue

    return get_list to if cell == to

    neighbors = find_free_neighbors cell, visited

    add_items_to_queue queue, neighbors, cell
  end
end
```

but there's something wrong. It enters an infinite loop. Upon closer inspection it looks like I forgot to call `to_a` in a cell somewhere. 

