import strscans, strutils, sequtils

proc input(file:string):seq[string] =
  for line in file.lines:
    result.add(line)

proc solve1(input:seq[string]):int =
  var visited:seq[int]
  var cur:int
  var acc:int
  while true:
    
    if cur in visited:
      return acc

    visited.add(cur)

    var line = input[cur]
    var num: int
    var inst: string
    discard scanf(line, "$w $i", inst, num)
    
    case inst:
      of "nop":
        inc(cur)
      of "jmp":
        inc(cur, num)
      of "acc":
        inc(acc, num)
        inc(cur)
    

    


proc solve2(input:seq[string], find:string, replace:string):int =
  var inp = input
  var visited:seq[int]
  var cur:int
  var acc:int
  var cur_nop:int #currently changed nop

  while true:
    if cur >= inp.len:
      return acc
    elif cur in visited:
      # change nop to jmp one at a time and set cur back to 0
      inp = input
      cur = 0
      acc = 0
      for pos, i in input:
        if i[0..2] == find and pos > cur_nop:
          inp[pos] = i.replace(find, replace)
          visited = @[]
          cur_nop = pos
          break
    
    visited.add(cur)
    
    var line = inp[cur]
    var num: int
    var inst: string
    discard scanf(line, "$w $i", inst, num)
    
    case inst:
      of "nop":
        inc(cur)
      of "jmp":
        inc(cur, num)
      of "acc":
        inc(acc, num)
        inc(cur)

echo "Part 1 answer: ", solve1(input("./aoc_2020_08.txt")) 
echo "Part 2 answer: ", solve2(input("./aoc_2020_08.txt"), "jmp", "nop")