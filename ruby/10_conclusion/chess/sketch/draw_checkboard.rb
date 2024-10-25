BLACK = { p: "", r: "1", n: "♞", b: "♝", q: "♛", k: "♚" }
WHITE = { p: "♙", r: "♖", n: "♘", b: "♗", q: "♕", k: "♔" }

def draw_board(state, perspective)
  if perspective == "black"
    state = state.reverse
  end

  str = ""

  state.each_with_index do |rank, rank_index|
    rank.each_with_index do |square, square_index|
    end
    str += "\n"
  end
end
