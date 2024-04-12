def stock_picker prices
  pair = [prices[0], prices[1]]
  highest = prices[1] - prices[0]
  
  i = 0
  while i < prices.length - 1
    j = i + 1
    while j < prices.length
      value = prices[j] - prices[i]

      if highest < value
        highest = value
        pair = [i, j]
      end

      j += 1
    end

    i += 1
  end

  pair
end

p stock_picker [17,3,6,9,15,8,6,1,10] 
p stock_picker [1, 10, 20, 30, 20, 10]
p stock_picker [10, 20, 30, 50, 100]
