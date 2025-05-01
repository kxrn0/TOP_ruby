def stock_picker(prices)
  pair = [0, 0]
  highest = -1 * Float::INFINITY
  last = prices.size - 1

  (0...last).each do |i|
    ((i + 1)..last).each do |j|
      diff = prices[j] - prices[i]

      if diff > highest
        highest = diff
        pair[0] = i
        pair[1] = j
      end
    end
  end

  pair
end

p stock_picker [17, 3, 6, 9, 15, 8, 6, 1, 10]
p stock_picker [1, 10, 20, 30, 20, 10]
p stock_picker [10, 20, 30, 50, 100]
