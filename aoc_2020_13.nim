import sequtils, strutils, math, parseutils

var ts:int = 1002394
var buses:seq[int] = "13,x,x,41,x,x,x,37,x,x,x,x,x,419,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19,x,x,x,23,x,x,x,x,x,29,x,421,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,17".replace("x,","").split(",").map(proc(x:string):int = x.parseInt)
var buses2:seq[int] = "13,x,x,41,x,x,x,37,x,x,x,x,x,419,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19,x,x,x,23,x,x,x,x,x,29,x,421,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,17".replace("x,", "0,").split(",").map(proc(x:string):int = x.parseInt)


proc solve1(ts: int, buses:seq[int]): int =
  var wait_time:int
  var w:seq[int]
  for c in buses:
    if c != 0:
      wait_time = abs((ts mod c) - c)
      w.add(wait_time)
  
  var r: int = w.max
  for k, v in w:
    if v < r:
      r = v
      result = v * buses[k]


proc solve2(input:seq[int]): int64 = 
  var minValue:int64 = 0
  var runningProduct:int64 = 1
  for k, v in input:
    if v != 0:
      while (minValue + int64 k) mod  (int64 v) != 0:
        minValue += runningProduct
      
      runningProduct *= (int64 v)

  return minValue

echo "Answer part 1: ", solve1(ts, buses)
echo "Answer part 2: ", solve2(buses2)