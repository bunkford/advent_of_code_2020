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

echo "Answer part 1: ", solve1(input("./aoc_2020_10.txt"))