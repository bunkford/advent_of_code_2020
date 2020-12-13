import sequtils, strutils

var ts:int = 1002394
var buses:seq[int] = "13,x,x,41,x,x,x,37,x,x,x,x,x,419,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19,x,x,x,23,x,x,x,x,x,29,x,421,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,17".replace("x,","").split(",").map(proc(x:string):int = x.parseInt)

echo buses
var ts_test = 939
var buses_test:seq[int] = @[7,13,59,31,19]

proc solve1(ts: int, buses:seq[int]): int =
  var wait_time:int
  var w:seq[int]
  for c in buses:
    wait_time = abs((ts mod c) - c)
    w.add(wait_time)
  
  var r: int = w.max
  for k, v in w:
    if v < r:
      r = v
      result = v * buses[k]

echo "Answer part 1: ", solve1(ts, buses)