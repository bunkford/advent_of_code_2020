import tables

var input = @[11,0,1,10,5,19]

proc solve(input: var seq[int], to: int): int =
 
  var last_spoken = initTable[int, seq[int]]() # keep track of last time it was spoken
  var count = input.toCountTable # keep track of the number of times it was spoken

  for k, v in input: # starting numbers
    last_spoken.mgetOrPut(v, @[]).add(k)
  
  while input.len < to:
    let prev = input[^1] # previously spoken
    let n = 
      if count[prev] == 1: 0 # if first time the number has been spoken
      else: # number had been spoken before; difference between last two times
        let n2 = last_spoken[prev][^1]
        let n3 = last_spoken[prev][^2]
        n2 - n3

    count.inc(n) # increase the count for what is said on this turn
    last_spoken.mgetOrPut(n, @[]).add(input.len) # add what was said on this turn 
    input.add(n) # add turn to input
  
  return input[^1] # last number spoken


echo "Answer part 1: ", solve(input, 2020)
echo "Answer part 2: ", solve(input, 30000000)

