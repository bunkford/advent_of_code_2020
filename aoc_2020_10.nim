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
  var inp = @[0] & input & @[input.max + 3] #effective joltage rating +  adapter joltage ratings + device built in joltage adapter rating (!! adapter joltage ratings are already sorted)
  var posibilities = newSeq[int64](inp.len)
  posibilities[0] = input.min # difference between effective joltage rating and first adapter
  for i in 0 ..< posibilities.len:
    for j in i - 3 ..< i:
      if j >= 0 and inp[i] <= inp[j] + 3:
        posibilities[i] += posibilities[j]

  return posibilities[^1]

echo "Answer part 1: ", solve1(input("./aoc_2020_10.txt"))
echo "Answer part 2: ", solve2(input("./aoc_2020_10.txt")) 