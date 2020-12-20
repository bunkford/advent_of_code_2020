import tables, strutils

proc reverse*(str: string): string =
  ## revers a string
  for index in countdown(str.high, 0):
    result.add(str[index])

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
  result['1'] = n.reverse()
  result['2'] = e.reverse()
  result['3'] = s.reverse()
  result['4'] = w.reverse()


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
            echo "Tile: ", tile_number, " Direction: ", direction, " <-> Tile: ", match_tile_number, " Direction: ", match_direction  
            #matches.inc(tile_number)
            matches.inc(match_tile_number)

  for tile_number, number in matches:
    echo tile_number, ": ", number
    if number == 4: # only corner pieces will have 4 matches. forward and reversed (flipped)
      echo "CORNER: ", tile_number
      result *= tile_number

echo "Answer Part 1: ", solve1(input("./aoc_2020_20.txt"))
