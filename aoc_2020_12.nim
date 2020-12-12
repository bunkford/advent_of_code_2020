import sequtils, strutils, math

proc input(file: string): seq[string] =
  for line in file.lines:
    result.add(line)


proc solve1(input: seq[string]): int =
  var angle:int
  var x: int 
  var y: int
  for line in input:
    var task: char = line[0]
    var value: int = line[1..line.high].parseInt
    case task:
      of 'N':
        inc(y, value)
      of 'S':
        dec(y, value)
      of 'E':
        inc(x, value)
      of 'W':
        dec(x, value)
      of 'L':
       inc(angle, value)
      of 'R':
       dec(angle, value)
      of 'F':
        var rad = (PI * angle.toFloat) / 180
        inc(x, value * cos(rad).toInt) 
        inc(y, value * sin(rad).toInt)
      else:
        discard

  return abs(x) + abs(y)

proc solve2(input: seq[string]): int =
  discard


echo "Part 1 answer: ", solve1(input("./aoc_2020_12.txt"))
echo "Part 2 answer: ", solve2(input("./aoc_2020_12.test"))
