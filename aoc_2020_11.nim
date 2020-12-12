import sequtils, strutils, tables

proc input(file: string): seq[string] =
  for line in file.lines:
    result.add(line)

# x, y
var directions = {"N": (0, -1), "S": (0, 1), "E": (-1, 0), "W": (1, 0), "NE": (-1, 1), "SE": (1, 1), "SW": (-1, -1), "NW": (1, -1)}.toTable

proc get_neigbours_ng(input:seq[string], col:int, row:int, visible:bool):seq[string] =
  for dir, coords in directions:
    var x = col + coords[0]
    var y = row + coords[1]
    while  x >= 0 and x <= input.high and y >= 0 and y <= input[row].high:
      if not visible:
        # return direct neighbours
        result.add($input[x][y])
        break
      if visible:
        # return first neighbour that isn't floor
        if input[x][y] != '.':
          result.add($input[x][y])
          break
        inc(x, coords[0])
        inc(y, coords[1])

proc get_visible(input:seq[string], row: int, col: int):seq[string] =
  # needs to be only first visible seat.. not all visible seats

  var xf, xs:int = -1 
  for x in 0..input[row].high: 
    if x < col and input[row][x] != '.': # W
      xf = x
    if x > col and input[row][x] != '.': # E
      xs = x 
      break
  
  if xf > -1: 
    result.add($input[row][xf]) 

  if xs > -1: 
    result.add($input[row][xs])

  var yf, ys:int = -1
  for  y in 0..input.high:
    if y < row and input[y][col] != '.': # N
      yf = y
    if y > row and input[y][col] != '.': # S
      ys = y 
      break
  
  if yf > -1: 
    result.add($input[yf][col])

  if ys > -1: 
    result.add($input[ys][col])

  var x1, y1, x2, y2, x3, y3, x4, y4:int = -1
      
  for y in 0..input.high:
    for x in 0..input[y].high:
      if abs(x - col) == abs(y-row): # 45 degree angles from point

        if x < col and y < row and input[y][x] != '.': #NW
          x1 = x
          y1 = y
        
        if x < col and y > row and input[y][x] != '.' and (x2 == -1 and y2 == -1): # SW
          x2 = x
          y2 = y
       
        if  x > col and y < row and input[y][x] != '.': # NE
          x3 = x
          y3 = y
          
        if x > col and y > row and input[y][x] != '.' and (x4 == -1 and y4 == -1): # SE
          x4 = x
          y4 = y


  if x1 > -1 and y1  > -1: 
    result.add($input[y1][x1])

  if x2 > -1 and y2  > -1: 
    result.add($input[y2][x2])

  if x3 > -1 and y3  > -1: 
    result.add($input[y3][x3])

  if x4 > -1 and y4  > -1: 
    result.add($input[y4][x4])

    
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
        var neighbours = get_neigbours_ng(current_input, x, y, false)
        if seat == 'L' and neighbours.count("#") == 0: next_input[x][y] = '#'
        if seat == '#' and neighbours.count("#") >= 4: next_input[x][y] = 'L'
  
    if current_input == next_input: 
      return current_input.join.count("#")

    current_input = next_input
    

proc solve2(input:seq[string]):int = 
  var current_input, next_input = input

  while true:
    for x in 0..current_input.high:
      for y in 0..current_input[x].high:
        var seat = current_input[x][y]
        var visible = get_neigbours_ng(current_input, x, y, true)

        if seat == 'L' and visible.count("#") == 0: next_input[x][y] = '#'
        if seat == '#' and visible.count("#") >= 5: next_input[x][y] = 'L'
        
    if current_input == next_input: 
      return current_input.join.count("#")

    current_input = next_input
  
echo "Part 1 answer: ", solve1(input("./aoc_2020_11.txt")) 
.echo "Part 2 answer: ", solve2(input("./aoc_2020_11.test")) 