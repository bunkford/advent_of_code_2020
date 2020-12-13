import sequtils, strutils, math, parseutils

var ts:int = 1002394
var buses:seq[int] = "13,x,x,41,x,x,x,37,x,x,x,x,x,419,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19,x,x,x,23,x,x,x,x,x,29,x,421,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,17".replace("x,","").split(",").map(proc(x:string):int = x.parseInt)
var buses2:seq[int] = "13,x,x,41,x,x,x,37,x,x,x,x,x,419,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19,x,x,x,23,x,x,x,x,x,29,x,421,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,17".replace("x,", "0,").split(",").map(proc(x:string):int = x.parseInt)

var ts_test = 939
var buses_test:seq[int] = @[7,13,59,31,19]

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


proc solve2(buses:seq[int]): uint64 =
  var chinese_remainder_theorem:string
  
  var deltas:seq[int]
  for delay, id in buses:
      deltas.add(id)

  for delay, id in buses:
    if id != 0:
      #echo "Bus: ", id, " Delay: ", delay 
      chinese_remainder_theorem = chinese_remainder_theorem & "(t + " & $delay & ") mod " & $id & " = 0,\n"
  echo chinese_remainder_theorem # punch this into wolfram alpha, this is how I got my answer. 
  
#Below is what wolfram if doing, stolen from https://github.com/dcurrie/AdventOfCode/



proc extended_gcd(a: int64, b: int64): (int64, int64, int64, int64, int64) =
    var s:int64 = 0
    var old_s:int64 = 1
    var t:int64 = 1
    var old_t:int64 = 0
    var r:int64 = b
    var old_r:int64 = a

    while r != 0:
        let quotient:int64 = floorDiv(old_r, r)
        (old_r, r) = (r, old_r - quotient * r)
        (old_s, s) = (s, old_s - quotient * s)
        (old_t, t) = (t, old_t - quotient * t)

    return (old_r, old_s, old_t, t, s)

type
    Busses = seq[tuple[n: int, id: int64, rem: int64]]

proc crt(xys: Busses): (bool, int64) = 
    var p:int64 = xys.foldl(a * b.id, int64(1))
    var r:int64 = 0
    for b in xys:
        var x = b.id
        var y = b.rem
        let q = floorDiv(p, x)
        let (z,s,t,qt,qs) = q.extended_gcd(x)
        if z != 1:
            return (false, x)
        if s < 0: r += y * (s + x) * q
        else:     r += y * s       * q
    return (true, r mod p)


proc part2(input: string): int64 =
    var line = input.split(',')
    var ids: Busses
    var maxid: int64 = -1
    var maxidn: int
    for n, idstr in line.pairs:
        var id: int
        if parseutils.parseInt(idstr, id) > 0:
            ids.add((n, int64(id), int64(if n == 0: 0 else: id - n)))
            if id > maxid:
                maxid = id
                maxidn = n
    let (ok,t) = crt(ids)
    result = t

echo "Answer part 1: ", solve1(ts, buses)
echo "Answer part 2: ", part2("13,x,x,41,x,x,x,37,x,x,x,x,x,419,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19,x,x,x,23,x,x,x,x,x,29,x,421,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,17")