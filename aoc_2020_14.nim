
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


iterator product(s: openArray[int], repeat: Positive): seq[int] =

  var counters = newSeq[int](repeat)

  block outer:
    while true:
      var result = newSeq[int](repeat)
      for i, cnt in counters:
        result[i] = s[cnt]
      yield result

      var i = repeat - 1
      while true:
        inc counters[i]
        if counters[i] == s.len:
          counters[i] = 0
          dec i
        else: break
        if i < 0:
          break outer

proc solve2(filename: string): int64 =
  var mask: string
  var memory = initTable[int64, int64]()
  for line in filename.lines:

    var mem, num: int

    # set mask
    if line[0..3] == "mask":
      mask = line.split(" = ")[1]
    
    elif scanf(line, "mem[$i] = $i", mem, num):
      var n = mem.toBin(36)
      for k, d in mask:
          if d == '0': continue
          n[k] = d

      # need to get all combinations of 0's and 1'
      var s = @['0', '1'] 
      var repeat = mask.count("X")
      var counters = newSeq[int](repeat)

      block outer:
        while true:
          var r = newSeq[char](repeat)
          for i, cnt in counters:
            r[i] = s[cnt]

          # r now contains a variation 
          var t = n
          for i in 0..n.high:
            if t[i] == 'X':
              t[i] = r.pop()
          
          memory[t.fromBin[:int64]] = num

          var i = repeat - 1
          while true:
            inc counters[i]
            if counters[i] == s.len:
              counters[i] = 0
              dec i
            else: break
            if i < 0:
              break outer


  return toSeq(memory.values).foldl(a + b)


echo "Answer part 1: ", solve1("./aoc_2020_14.txt") 

echo "Answer part 2: ", solve2("./aoc_2020_14.txt")