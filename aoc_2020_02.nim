import strutils, re

# put input into seq
proc input(file:string):seq[seq[string]] =
  var input: seq[seq[string]]
  for line in lines file:
    input.add(line.split(":"))
  return input

proc solve1(input:seq[seq[string]]):int =
  var good:int = 0
  for password in input:
    var letter = password[0].split(" ")[1]
    var min = password[0].split(" ")[0].split("-")[0].parseInt
    var max = password[0].split(" ")[0].split("-")[1].parseInt
    var how_many = password[1].count(letter)
    if how_many >= min and how_many <= max:
      inc(good)
  return good


proc solve2(input:seq[seq[string]]):int =
  var good:int = 0
  for password in input:
    var letter = password[0].split(" ")[1][0]
    var pos1 = password[0].split(" ")[0].split("-")[0].parseInt
    var pos2 = password[0].split(" ")[0].split("-")[1].parseInt
    
    if password[1][pos1] == letter xor password[1][pos2] == letter:
      inc(good)
  return good


echo "Answer part 1: ", solve1(input("./aoc_2020_02.txt"))
echo "Answer part 2: ", solve2(input("./aoc_2020_02.txt"))