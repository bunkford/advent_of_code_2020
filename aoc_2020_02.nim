import strutils, re


proc solve1(file: string):int =
  var good:int = 0
  for line in lines file:
    var p = line.findAll(re"\w+")
    var min = p[0].parseInt
    var max = p[1].parseInt
    var letter = p[2][0]
    var password = p[3]
    var how_many = password.count(letter)
    if how_many >= min and how_many <= max:
      inc(good)
  return good


proc solve2(file:string):int =
  var good:int = 0
  for line in lines file:
    var p = line.findAll(re"\w+")
    var pos1 = p[0].parseInt
    var pos2 = p[1].parseInt
    var letter = p[2][0]
    var password = p[3]
    if password[pos1-1] == letter xor password[pos2-1] == letter:
      inc(good)
  return good


echo "Answer part 1: ", solve1("./aoc_2020_02.txt")
echo "Answer part 2: ", solve2("./aoc_2020_02.txt")