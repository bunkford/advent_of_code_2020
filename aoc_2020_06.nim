import strutils, sequtils

proc input(file: string):seq[string] =
  var r = file.readFile.split("\n\n")
  r.applyIt(it.replace("\n", ""))
  return r

proc people(file: string):seq[int] =
  var r:seq[int]
  for line in file.readFile.split("\n\n"):
    r.add(line.count("\n") + 1)
  return r

proc solve1(input:seq[string]):int =
  var r: int
  for group in input:
    inc(r, group.toSeq.deduplicate.len)
  return r

proc solve2(input:seq[string], people:seq[int]):int =
  var r: int
  for key, group in input:
    for i in 97..122: # a - z
      if group.count($char(i)) == people[key]: inc(r)
  return r

echo "Answer part 1: " , solve1(input("./aoc_2020_06.txt"))
echo "Answer part 2: " , solve2(input("./aoc_2020_06.txt"), people("./aoc_2020_06.txt"))