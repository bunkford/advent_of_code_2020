
import strutils, strscans, tables, sequtils

proc solve1(filename: string): int64 =
  var mask: string
  var memory = initTable[int, int64]()

  for line in filename.lines:

    var mem, num: int

    # set mask
    if line[0..3] == "mask":
      mask = line.split(" = ")[1]
    
    elif scanf(line, "mem[$i] = $i", mem, num):
      var n = num.toBin(36)
      for k, d in mask:
        if d != 'X':
          n[k] = d
      memory[mem] = n.fromBin[:int64] 
  
  return toSeq(memory.values).foldl(a + b)

echo "Answer part 1: ", solve1("./aoc_2020_14.txt") 
