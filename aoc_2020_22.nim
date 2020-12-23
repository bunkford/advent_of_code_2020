import deques

var player1 = @[19,22,43,38,23,21,2,40,31,17,27,28,35,44,41,47,50,7,39,5,42,25,33,3,48].toDeque()
var player2 = @[16,24,36,6,34,11,8,30,26,15,9,10,14,1,12,4,32,13,18,46,37,29,20,45,49].toDeque()



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

echo "Answer part 1: ", solve1(player1, player2) 



