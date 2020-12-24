import deques, sets, hashes

var player1test = @[9,2,6,3,1].toDeque()
var player2test = @[5,8,4,7,10].toDeque()

var player1 = @[19,22,43,38,23,21,2,40,31,17,27,28,35,44,41,47,50,7,39,5,42,25,33,3,48].toDeque()
var player2 = @[16,24,36,6,34,11,8,30,26,15,9,10,14,1,12,4,32,13,18,46,37,29,20,45,49].toDeque()

var playera = player1
var playerb = player2


proc solve1(player1:var Deque, player2:var Deque): int =
  while player1.len > 0 and player2.len > 0:
    var d1 = player1.popFirst()
    var d2 = player2.popFirst()
    if d1 > d2:
      player1.addLast(d1)
      player1.addLast(d2)
    elif d2 > d1:
      player2.addLast(d2)
      player2.addLast(d1)

  var i = 1
  while player1.len > 0:
    result += player1.popLast() * i
    inc(i) 
  while player2.len > 0:
    result += player2.popLast() * i
    inc(i) 

proc solve2(player1:var Deque, player2:var Deque): (int, Deque[int], Deque[int]) =
  var conf1, conf2: HashSet[int]

  while player1.len > 0 and player2.len > 0:

    var h1, h2: Hash = 0
    for x in player1: h1 = h1 !& x
    for x in player2: h2 = h2 !& x
    if h1 in conf1:
      return (1, player1, player2)
    conf1.incl(h1)
    if h2 in conf2:
      return (1, player1, player2)
    conf2.incl(h2)

    var d1 = player1.popFirst()
    var d2 = player2.popFirst()

    if d1 <= player1.len and d2 <= player2.len:
      var n1, n2 = initDeque[int]()
      for i in 0..<d1: n1.addLast(player1[i])
      for i in 0..<d2: n2.addLast(player2[i])
      let (winner, _, _) = solve2(n1, n2)
      if winner == 1:
        player1.addLast(d1)
        player1.addLast(d2)
      elif winner == 2:
        player2.addLast(d2)
        player2.addLast(d1)
    
    elif d1 > d2:
      player1.addLast(d1)
      player1.addLast(d2)
    elif d2 > d1:
      player2.addLast(d2)
      player2.addLast(d1)
  
  var winner: int
  if player1.len > 0: winner = 1
  elif player2.len > 0: winner = 2
  return (winner, player1, player2)


echo "Answer part 1: ", solve1(player1, player2) 

var (n, a, b) = solve2(playera, playerb)
var i = 1
var answer2:int
while a.len > 0:
  answer2 += a.popLast() * i
  inc(i) 
while b.len > 0:
  answer2 += b.popLast() * i
  inc(i) 
echo "Answer part 2: ", answer2



