import strutils

proc input(file: string): seq[BiggestUInt] =
  for line in file.lines:
    result.add(line.parseBiggestUInt)

proc perms(input:seq[BiggestUInt], e:BiggestUInt):bool =
  # check permutations of two numbers in seq that add to equal e
  for a in 0 .. input.len - 1:
    # a is  first didgit
    for b in 0 .. input.len - 1:
      if a != b: # can't sum itself
        if input[a] + input[b] == e:
          return true
  return false 

proc solve1(input: seq[BiggestUInt], preamble: int): BiggestUInt =
  for i in preamble..input.len:
    if not perms(input[i-preamble..i], input[i]):
      return input[i]

        

proc solve2(input: seq[BiggestUInt]): BiggestUInt =
  discard

echo "Part 1 answer: ", solve1(input("aoc_2020_09.txt"), 25)
echo "Part 2 answer: ", solve2(input("aoc_2020_09.test"))
