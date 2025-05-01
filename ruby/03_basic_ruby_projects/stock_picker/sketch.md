For each day, check the difference between each other day in the future and this day. I'll have to keep track of the current highest pair. It would be good to keep track of the highest sum seen until now.

At some point I'll have a pair and a sum, for example [4, 7], 1000. I'll be checking two other indices, say [13, 18], and if I find their difference to be higher than the currently highest sum, for example 2000, I'll replace the current data with the new one, so the new pair and sum are [13, 18], 2000.

What do Initialize the pair and sum to? I can initialize the sum to `-Float::INFINITY`, but what about the pair? Maybe the pair should be initialized to the first two elements, and the sum to their difference?

The code looks rather difficult to read, I'm sure that's because back then I first solved this in javascript, and then awkwardly translated it to ruby. In fact, even now I can quickly come up with a js solution

```js
function pick(prices) {
  const indices = [0, 0];
  let highest = Number.NEGATIVE_INFINITY;

  for (let i = 0; i < prices.length - 1; i++)
    for (let j = i + 1; j < prices.length; j++) {
      const diff = prices[j] - prices[i];

      if (diff > highest) {
        highest = diff;
        indices[0] = i;
        indices[1] = j;
      }
    }

  return indices;
}
```

but a ruby solution is still not as immediately obvious as the js one, but it's not too hard to come up with it.

```ruby
def pick prices
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
```
