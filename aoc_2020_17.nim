import tables, sequtils, strutils

proc input(file: string):seq[seq[string]] =
  var start:seq[string]
  for line in file.lines:
    start.add(line)
  result.add(start)

# expand space in every direction
proc expand(input: seq[seq[string]]):seq[seq[string]] =
  var new_input: seq[seq[string]]
  # expand x and y directions by one unit each way
  for z, dimension in input:
    var new_dimension:seq[string]
    for y in -1 .. dimension[z].high + 1:
      var row:string
      for x in -1 .. (dimension.high + 1):
        if y == -1 or y == dimension[0].high + 1:
          # add a row of dots
          row = row & "."
        else:
          if x == -1 or x == dimension[0].high + 1:
            row = row & "."
          else:
            row = row & $dimension[y][x]
      new_dimension.add(row)
    new_input.add(new_dimension)

  # crete empty expansion for the z axis
  var blank:seq[string]
  for y in 0 .. new_input[0].high:
    var row:string
    for x in 0 .. new_input[0][0].high:
      row = row & "."
    blank.add(row)
  result = blank & new_input & blank

proc get_neigbours(input:seq[seq[string]], col:int, row:int, dimension:int, include_self:bool = false):seq[string] =
  # x, y
  var directions = {"N": (0, -1), "S": (0, 1), "E": (-1, 0), "W": (1, 0), "NE": (-1, 1), "SE": (1, 1), "SW": (-1, -1), "NW": (1, -1)}.toTable
  for z in dimension - 1 .. dimension + 1:
    if z >= 0 and z <= input.len - 1:
      if dimension != z or include_self == true:
        # add the self spot in the parallel dimensions
        result.add($input[z][row][col])
        #echo "Z: ", z , " Row: ", row, " Col: ", col
      for dir, coords in directions:
        var x = col + coords[0]
        var y = row + coords[1]
        if  x >= 0 and x <= input[0][row].high and y >= 0 and y <= input[0][row].high:
          # return direct neighbours
          result.add($input[z][y][x])
        else:
          result.add(".")


proc solve1(input:seq[seq[string]]): int =
  var current_input, next_input = expand(input)
  for i in 1 .. 6:
    for z in 0..current_input.high:
      for y in 0..current_input[z].high:
        for x in 0..current_input[z][y].high:
          var cube = current_input[z][y][x]
          var neighbours = get_neigbours(current_input, x, y, z)
          if cube == '#' and neighbours.count("#") notin [2, 3]: next_input[z][y][x] = '.'
          if cube == '.' and neighbours.count("#") in [3]: next_input[z][y][x] = '#' 

    current_input = expand(next_input)
    next_input = current_input    

  for z in next_input:
    for y in z:
      result += y.join().count("#")

proc blank_w(input:seq[seq[string]]):seq[seq[string]] =
    for z in 0..input.high:
      result.add(@[])
      for y in 0..input[z].high:
        result[z].add(input[z][y].replace("#", "."))



proc solve2(input:seq[seq[string]]): int = 
  var current_input, next_input = expand(input)

  var w:seq[seq[seq[string]]] = @[input]
  var empty_w = blank_w(current_input)
  var current_w:seq[seq[seq[string]]] = @[empty_w, current_input, empty_w]
  var next_w = current_w

  for i in 1 .. 6:
    for w_idx in 0 .. current_w.high:    
      for z in 0..current_w[w_idx].high:
        for y in 0..current_w[w_idx][z].high:
          for x in 0..current_w[w_idx][z][y].high:
            var cube = current_w[w_idx][z][y][x]
            var neighbours = get_neigbours(current_w[w_idx], x, y, z, false)
            if w_idx > 0: neighbours = neighbours & get_neigbours(current_w[(w_idx - 1)], x, y, z, true)
            if w_idx < current_w.high: neighbours = neighbours & get_neigbours(current_w[w_idx + 1], x, y, z, true)
            if cube == '#' and neighbours.count("#") notin [2, 3]: next_w[w_idx][z][y][x] = '.'
            if cube == '.' and neighbours.count("#") in [3]: next_w[w_idx][z][y][x] = '#' 

    # do the expansion
    var tmp: seq[seq[seq[string]]]
    for w in next_w:
      tmp.add(expand(w))
    current_w = blank_w(tmp[0]) & tmp & blank_w(tmp[0])
    next_w = current_w

  for w in next_w:
    for z in w:
      for y in z:
        result += y.join().count("#")


echo "Answer part 1: ", solve1(input("./aoc_2020_17.txt"))
echo "Answer part 2: ", solve2(input("./aoc_2020_17.txt"))
