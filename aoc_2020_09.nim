import strutils

proc input(file: string): seq[BiggestUInt] =
  for line in file.lines:
    result.add(line.parseBiggestUInt)

proc perms(input:seq[BiggestUInt], e:BiggestUInt):bool =
  # check permutations of two numbers in seq that add to equal e
  for a in 0 ..< input.len:
    # a is  first digit
    for b in 0 ..< input.len:
      # b is second digit
      if a != b: # can't sum itself
        if input[a] + input[b] == e:
          return true
  return false 

proc solve1(input: seq[BiggestUInt], preamble: int): BiggestUInt =
  for i in preamble..input.len:
    if not perms(input[i-preamble..i], input[i]):
      return input[i]

        

proc solve2(input: seq[BiggestUInt], invalid_step1:BiggestUInt): BiggestUInt =
  var num:BiggestUInt
  for a in 0 ..< input.len:
    num = input[a]
    var min:BiggestUInt = num
    var max:BiggestUInt = num
    for b in a ..< input.len:
      if b != a:
        if input[b] < min: min = input[b]
        if input[b] > max: max = input[b]
        num = num + input[b]
        if num == invalid_step1:
          return min + max
        if num > invalid_step1:
          break

echo "Part 1 answer: ", solve1(input("aoc_2020_09.txt"), 25)
echo "Part 2 answer: ", solve2(input("aoc_2020_09.txt"), solve1(input("aoc_2020_09.txt"), 25))
