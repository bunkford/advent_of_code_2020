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
  var x, y, dx, dy, angle: int

  dx = 10
  dy = 1

  for line in input:
    var task: char = line[0]
    var value: int = line[1..line.high].parseInt 

    case task:
      of 'N':
        inc(dy, value)
      of 'S':
        dec(dy, value)
      of 'E':
        inc(dx, value)
      of 'W':
        dec(dx, value)
      of 'L', 'R':
        var d_rad = degToRad(value.toFloat)
        var radius = sqrt(dx.toFloat^2 + dy.toFloat^2)
        if task == 'R':
          d_rad = d_rad * -1
        var rad = arctan2(dy.toFloat, dx.toFloat) + d_rad
        dy = (radius * sin(rad)).toInt
        dx = (radius * cos(rad)).toInt
      of 'F':
        inc(x, dx * value)
        inc(y, dy * value)
      else:
        discard
  return abs(x) + abs(y)

echo "Part 1 answer: ", solve1(input("./aoc_2020_12.txt"))
echo "Part 2 answer: ", solve2(input("./aoc_2020_12.txt"))
