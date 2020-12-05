import strutils, algorithm, sequtils

proc input(file: string): seq[string] =
  var r: seq[string]
  for line in file.lines:
    r.add(line)
  return r

proc part1(input: seq[string]): int =
  var cur: int
  var t: seq[int]
  for line in input:
    var row = line[0..6]
    row = row.replace("F", "0")
    row = row.replace("B", "1")
    var r = fromBin[int](row)

    var column = line[7..9]
    column = column.replace("R", "1")
    column = column.replace("L", "0")
    var c = fromBin[int](column)

    if r * 8 + c > cur:
      cur = r * 8 + c

  return cur

proc part2(input: seq[string]): int =
  var cur: int
  var t: seq[int]
  for line in input:
    var row = line[0..6]
    row = row.replace("F", "0")
    row = row.replace("B", "1")
    var r = fromBin[int](row)

    var column = line[7..9]
    column = column.replace("R", "1")
    column = column.replace("L", "0")
    var c = fromBin[int](column)

    t.add(r * 8 + c)


  sort(t, system.cmp[int])


  for seat in t:
    if (seat in t) and (seat + 2 in t) and (seat + 1 notin t):
      return seat + 1


echo "Part 1 answer: ", part1(input("./aoc_2020_05.txt"))
echo "Part 2 answer: ", part2(input("./aoc_2020_05.txt"))
