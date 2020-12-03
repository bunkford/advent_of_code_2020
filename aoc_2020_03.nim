
# put input into seq
proc input(file:string):seq[string] =
  var input: seq[string]
  for line in lines file:
    input.add(line)
  return input

proc solve1(input:seq[string]):int =
  var x, y, trees = 0
  var total_slope = input.len - 1
  while y <= total_slope - 1:
    inc(y, 1)
    inc(x, 3)
    if x > input[y].len - 1:
      x = x - input[y].len
    if input[y][x] == '#':
      inc(trees)
  return trees

echo "Part 1 answer: ", solve1(input("./aoc_2020_03.txt")), " trees"