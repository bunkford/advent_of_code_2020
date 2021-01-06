import strutils, lists

var test = @[3,8,9,1,2,5,4,6,7]
var input = @[1,9,3,4,6,7,2,5,8]

proc solve1(input:seq[int]):int = 
  var circle: DoublyLinkedRing[int]
  for i in input: circle.append(i)

  var cur = circle.head # current cup

  for i in 1 .. 100:

    # pointers to start and end
    var s = cur.next
    var e = s.next.next

    # find destination cup number
    var dest = cur.value - 1
    if dest == 0: dest = 9
    while dest in [s.value, s.next.value, e.value]: 
      dec(dest)
      if dest == 0: dest = 9  

    var d = circle.find(dest)

  
    # remove 3 picked up values
    cur.next = e.next
    cur.next.prev = cur
    # put back the cups
    d.next.prev = e
    e.next = d.next
    d.next = s
    s.prev = d
    # and change current
    cur = cur.next
  
  # find answer
  var start = circle.find(1)
  var ans: string
  for i in 1 ..< input.len:
    ans = ans & $start.next.value
    start = start.next
  return parseInt(ans)


echo "Answer part 1: ", solve1(test)
