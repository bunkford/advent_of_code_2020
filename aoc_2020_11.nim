import sequtils, strutils

proc input(file: string): seq[string] =
  for line in file.lines:
    result.add(line)


proc get_neigbours(input:seq[string], row: int, col: int):seq[string] =
  # get the adjacent (up, down, left, right, diagonal) neighbours
  # 1 2 3
  # 4 ? 5
  # 6 7 8
  if col > 0 and row > 0: result.add($input[row-1][col-1]) # 1
  if row > 0: result.add($input[row-1][col]) # 2
  if col < input[0].high and row > 0: result.add($input[row-1][col+1]) # 3

  if col < input[0].high: result.add($input[row][col+1]) # 4
  if col > 0: result.add($input[row][col-1]) # 5
  
  if col > 0 and row < input.high: result.add($input[row+1][col-1]) # 6
  if row < input.high: result.add($input[row+1][col]) # 7 
  if col < input[0].high and row < input.high: result.add($input[row+1][col+1]) # 8

  
proc solve1(input:seq[string]):int = 
  var current_input, next_input = input

  while true:
    for x in 0..current_input.high:
      for y in 0..current_input[x].high:
        var seat = current_input[x][y]
        var neighbours = get_neigbours(current_input, x, y)
        if seat == 'L' and neighbours.count("#") == 0: next_input[x][y] = '#'
        if seat == '#' and neighbours.count("#") >= 4: next_input[x][y] = 'L'
        
    if current_input == next_input: 
      return current_input.join.count("#")

    current_input = next_input
    

echo "Part 1 answer: ", solve1(input("./aoc_2020_11.txt"))