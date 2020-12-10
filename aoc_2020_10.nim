import strutils, sequtils, algorithm

proc input(file: string): seq[int] =
  for line in file.lines:
    result.add(line.parseInt)
  result.sort(cmp[int])

proc solve1(input:seq[int]):int =
  var cer = 0 # charger effective joltage rating
  var cur = 0 # current joltage
  var diffs: seq[int]
  for i in input:
    if i <= cur + 3:
      diffs.add(i-cur)
      cur = i
    else:
      echo "Uncompatable adapter Found: ", i
      break
  diffs.add(3) # built in device diff
  var ones: int = diffs.count(1)
  var threes: int = diffs.count(3)
  return ones * threes

proc solve2(input:seq[int]):int64 = 
  var inp = @[0] & input & @[input.max + 3] #effective joltage rating +  adapter joltage ratings + device built in joltage adapter rating
  var posibilities = newSeq[int64](inp.len)
  posibilities[0] = input.min # difference between effective joltage rating and first adapter
  for i in 1 ..< posibilities.len:
    posibilities[i] = posibilities[i - 1]
    if i >= 2 and inp[i] - inp[i - 2] <= 3: # add possible combinations
      posibilities[i] += posibilities[i - 2]
    if i >= 3 and inp[i] - inp[i - 3] <= 3: # add possible combinations
      posibilities[i] += posibilities[i - 3]
  return posibilities[^1]



echo "Answer part 1: ", solve1(input("./aoc_2020_10.txt"))
echo "Answer part 2: ", solve2(input("./aoc_2020_10.txt")) 