import tables, sequtils, math, strutils

proc input(file: string):seq[string] =
  for line in file.lines:
    result.add(line)

var offsets = {"e":  (2, 0), "se":  (1, -3), "sw":  (-1, -3), "w":  (-2, 0), "nw":  (-1, 3), "ne" : (1, 3)}.toTable
proc solve1(input:seq[string]):int =
  var tiles: Table[(int,int), int]
  for i in input:
    # create tokens: e, se, sw, w, nw, and ne
    var tokens:seq[string]
    var a:int
    while a < i.len:
      case i[a]:
      of 'e':
        tokens.add($i[a])
      of 'w': 
        tokens.add($i[a])
      else:
        tokens.add($i[a] & $i[a+1])
        inc(a)
      inc(a)
    
    var x, y:int
    for token in tokens:
      inc(x, offsets[token][0])
      inc(y, offsets[token][1])

    if (x, y) in tiles:
      tiles[(x, y)] = 1 - tiles[(x, y)] # toggle
    else:
      tiles[(x, y)] = 1

  return toSeq(tiles.values).sum



proc solve2(input:seq[string]):int =
  var tiles: Table[(int,int), int]
  for i in input:
    # create tokens: e, se, sw, w, nw, and ne
    var tokens:seq[string]
    var a:int
    while a < i.len:
      case i[a]:
      of 'e':
        tokens.add($i[a])
      of 'w': 
        tokens.add($i[a])
      else:
        tokens.add($i[a] & $i[a+1])
        inc(a)
      inc(a)
    
    var x, y:int
    for token in tokens:
      inc(x, offsets[token][0])
      inc(y, offsets[token][1])

    if (x, y) in tiles:
      tiles[(x, y)] = 1 - tiles[(x, y)] # toggle
    else:
      tiles[(x, y)] = 1

  for i in 1 .. 100:
    var newTiles: Table[(int, int), int] # use this because we change all the tiles at the same time

    # expand the tiles to check so we get edge cases
    var toCheck: seq[seq[int]]
    for loc, tile in tiles:
      if tile == 0: continue
      for offset in offsets.values:
        toCheck.add (@[loc[0] + offset[0], loc[1] + offset[1]])

    # check the tiles
    for loc in toCheck:
      var black = 0
      for offset in offsets.values:
        black += tiles.getOrDefault((loc[0] + offset[0], loc[1] + offset[1]), 0)

      var tile = tiles.getOrDefault((loc[0], loc[1]), 0)
      if tile == 0 and black == 2: 
        newTiles[(loc[0], loc[1])] = 1
      elif tile == 1 and black in [1,2]:
        newTiles[(loc[0], loc[1])] = 1

    tiles = newTiles # change all tiles at once
    #echo "Day ", i, ": ", toSeq(tiles.values).sum
  return toSeq(tiles.values).sum

echo "Answer part 1: ", solve1(input("./aoc_2020_24.txt"))
echo "Answer part 2: ", solve2(input("./aoc_2020_24.txt"))