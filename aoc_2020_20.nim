import tables, strutils, math

proc reverse*(str: string): string =
  ## revers a string
  for index in countdown(str.high, 0):
    result.add(str[index])

proc orientate(tile:seq[string], direction: char): seq[string] =
  var tmp = tile
  case direction:
    of 'y', 'Y':
      for i in 0 .. tile.high:
        result.add(tmp.pop())
    of 'x', 'X':
       for i in 0 .. tile.high:
         result.add(tmp[i].reverse())
    else:
      result = tile



proc input(filename:string):Table[int, seq[string]] =
  var tile_number:int
  var tile:seq[string]
  for line in filename.lines:
    if line.len > 0 and line[0..3] == "Tile": 
      tile_number = line.split(" ")[1].strip(chars={':'}).parseInt
      tile = @[]
    elif line.len > 0:
      tile.add(line)
    else:
      result[tile_number] = tile

  result[tile_number] = tile # eof

proc get_borders(tile:seq[string]): Table[char, string] = 
  var n, e, s, w: string
  n = tile[0]
  s = tile[^1]
  for line in tile:
    e.add($line[^1])
    w.add($line[0])
  result['n'] = n
  result['e'] = e
  result['s'] = s
  result['w'] = w
  result['N'] = n.reverse()
  result['E'] = e.reverse()
  result['S'] = s.reverse()
  result['W'] = w.reverse()


proc solve1(input:Table[int, seq[string]]): BiggestInt =
  result = 1
  var matches = initCountTable[int]()
  var borders:Table[int, Table[char, string]]
  for tile_number, tile in input:
    borders[tile_number] = get_borders(tile)
  
  for tile_number, b in borders:
    for direction, border in b:
      for match_tile_number, mb in borders:
        for match_direction, match_border in mb:
          if tile_number != match_tile_number and match_border == border:
            matches.inc(match_tile_number)

  for tile_number, number in matches:
    if number == 4: # only corner pieces will have 4 matches. forward and reversed (flipped)
      result *= tile_number




proc flip(tile: seq[string]): seq[string] =
  result = tile
  let h = tile.len
  let w = tile[0].len
  for i in 0 ..< h:
    for j in 0 ..< w: 
      result[i][j] = tile[i][w-1-j]


proc rotate(tile: seq[string], n: int): seq[string] =
  result = tile
  let h = tile.len
  let w = tile[0].len
  case n mod 4:
  of 0: return tile
  of 1: 
    for i in 0 ..< w:
      for j in 0 ..< h:
        result[i][j] = tile[j][w-i-1]
  else:
    return tile.rotate( (n+3) mod 4 ).rotate(1)



proc w(tile: seq[string]):string = 
  for i in 0 .. tile.high:
    result.add tile[i][0]

proc e(tile: seq[string]): string =
  for i in 0 .. tile.high:
    result.add tile[i][tile[0].high]

proc n(tile: seq[string]): string =
  result = tile[0] 

proc s(tile: seq[string]): string =
  result = tile[tile.high] 

proc get_match_s(input:Table[int, seq[string]], match_edge:string, match_id: int): (int, seq[string]) =    
  for id, tile in input:
    if id != match_id:
      if match_edge == n(rotate(tile, 0)): return (id, rotate(tile, 0))
      if match_edge == n(rotate(tile, 1)): return (id, rotate(tile, 1))
      if match_edge == n(rotate(tile, 2)): return (id, rotate(tile, 2))
      if match_edge == n(rotate(tile, 3)): return (id, rotate(tile, 3))

      if match_edge == n(flip(rotate(tile, 0))): return (id, flip(rotate(tile, 0)))
      if match_edge == n(flip(rotate(tile, 1))): return (id, flip(rotate(tile, 1)))
      if match_edge == n(flip(rotate(tile, 2))): return (id, flip(rotate(tile, 2)))
      if match_edge == n(flip(rotate(tile, 3))): return (id, flip(rotate(tile, 3)))

proc get_match_e(input:Table[int, seq[string]], match_edge:string, match_id: int): (int, seq[string]) =    
  for id, tile in input:
    if id != match_id:
      if match_edge == w(rotate(tile, 0)): return (id, rotate(tile, 0))
      if match_edge == w(rotate(tile, 1)): return (id, rotate(tile, 1))
      if match_edge == w(rotate(tile, 2)): return (id, rotate(tile, 2))
      if match_edge == w(rotate(tile, 3)): return (id, rotate(tile, 3))

      if match_edge == w(flip(rotate(tile, 0))): return (id, flip(rotate(tile, 0)))
      if match_edge == w(flip(rotate(tile, 1))): return (id, flip(rotate(tile, 1)))
      if match_edge == w(flip(rotate(tile, 2))): return (id, flip(rotate(tile, 2)))
      if match_edge == w(flip(rotate(tile, 3))): return (id, flip(rotate(tile, 3)))   
  

proc get_top_left(input:Table[int, seq[string]]): (int, seq[string]) = # (id, tile)
    for id, tile in input:
      if get_match_e(input, w(tile), id)[0] == 0 and get_match_s(input, n(tile), id)[0] == 0:
        return (id, tile)

proc trim(tile: seq[string]): seq[string] =
  for i in 1 .. tile.high - 1:
    result.add(tile[i][1..^2])

proc solve2(input:Table[int, seq[string]]): int =
  var map: seq[seq[seq[string]]]
  var id_map: seq[seq[int]]
  # size of map
  var size = sqrt(input.len.toFloat).toInt 
  
  
  # initialize map
  for y in 0 .. size - 1: 
    map.add(@[])
    id_map.add(@[])
    for x in 0 .. size - 1:
     map[y].add(@[])
     id_map[y].add(@[0])

  # place top left corner
  var top_left:(int, seq[string]) = get_top_left(input)
  id_map[0][0] = top_left[0]
  map[0][0] = top_left[1]

  for x in 0 .. size - 1:
    for y in 0 .. size - 1:
      if y > 0: # check south
        var south_edge_to_check = s(map[y - 1][x])
        var south_match = get_match_s(input, south_edge_to_check, id_map[y - 1][x])
        
        map[y][x] = south_match[1]
        id_map[y][x] = south_match[0]

      elif y == 0 and x > 0: # check east
        var east_edge_to_check = e(map[y][x - 1])
        var east_match = get_match_e(input, east_edge_to_check, id_map[y][x - 1])
        map[y][x] = east_match[1]
        id_map[y][x] = east_match[0]

  # Trim and make one big string
  var s:string
  for y in 0 .. size - 1:
    for line in 0 .. map[0][0].high - 2:
      for x in 0 .. size - 1:
        s = s & trim(map[y][x])[line]
      s = s & "\n"


  # look for monsters
  var monsters: int
  for rotate in 1 .. 8:
    var monster_hunter: seq[string]
    if rotate <= 4:
      monster_hunter = rotate(s[0..^2].split("\n"),rotate)
    else:
      monster_hunter = flip(rotate(s[0..^2].split("\n"),rotate - 4))
    for line in 0 .. monster_hunter.high - 3:
      for i in 19 .. monster_hunter[0].high - 1:
        if monster_hunter[line][i] == '#' and 
          monster_hunter[line + 1][i - 1 .. i + 1] == "###" and
          monster_hunter[line + 1][i - 7 .. i - 6] == "##" and
          monster_hunter[line + 1][i - 13.. i - 12] == "##" and
          monster_hunter[line + 1][i - 18] == '#' and 
          monster_hunter[line + 2][i - 2] == '#' and
          monster_hunter[line + 2][i - 5] == '#' and 
          monster_hunter[line + 2][i - 8] == '#' and
          monster_hunter[line + 2][i - 11] == '#' and
          monster_hunter[line + 2][i - 14] == '#' and
          monster_hunter[line + 2][i - 17] == '#':
            inc(monsters)
            monster_hunter[line][i] = 'O'
            monster_hunter[line + 1][i - 1 .. i + 1] = "OOO"
            monster_hunter[line + 1][i - 7 .. i - 6] = "OO"
            monster_hunter[line + 1][i - 13.. i - 12] = "OO"
            monster_hunter[line + 1][i - 18] = 'O' 
            monster_hunter[line + 2][i - 2] = 'O'
            monster_hunter[line + 2][i - 5] = 'O' 
            monster_hunter[line + 2][i - 8] = 'O'
            monster_hunter[line + 2][i - 11] = 'O'
            monster_hunter[line + 2][i - 14] = 'O'
            monster_hunter[line + 2][i - 17] = 'O'
    
    if monsters > 0:
      echo monster_hunter.join("\n")
      return monster_hunter.join("\n").count("#")


echo "Answer Part 1: ", solve1(input("./aoc_2020_20.txt"))
echo "Answer Part 2: ", solve2(input("./aoc_2020_20.txt"))
