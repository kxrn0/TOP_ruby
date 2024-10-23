BLACK = { p: "p", r: "r", n: "n", b: "b", q: "q", k: "k" }
WHITE = { p: "p", r: "r", n: "n", b: "b", q: "q", k: "k" }

def draw_board(state, turn)
  if turn == "black"
    state = state.reverse
  end

  str = ""

  state.each_with_index do |rank, rank_index|
    rank.each_with_index do |square, square_index|
    end
    str += "\n"
  end
end
