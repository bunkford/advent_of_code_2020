import tables, sequtils, math

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
  
echo "Answer part 1: ", solve1(input("./aoc_2020_24.txt"))
