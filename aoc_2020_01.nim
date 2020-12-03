import strutils 

# put input into seq
proc input(file:string):seq[int] =
  var input: seq[int]
  for line in lines file:
    input.add(line.parseInt)
  return input
   

proc solve(input:seq[int]):int =
  for x in input:
    for y in input:
      if x + y == 2020: return x*y

proc solve_3sum(input:seq[int]):int =
  for x in input:
    for y in input:
      for z in input:
        if x + y + z == 2020: return x*y*z

echo "Answer part 1: " , solve(input("./aoc_2020_01.txt"))
echo "Answer part 2: " , solve_3sum(input("./aoc_2020_01.txt"))