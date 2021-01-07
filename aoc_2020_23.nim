import strutils, lists, tables

var test = @[3,8,9,1,2,5,4,6,7]
var input = @[1,9,3,4,6,7,2,5,8]

proc solve1(input:seq[int]):int =
  var lookup: Table[int, DoublyLinkedNode[int]]

  var circle: DoublyLinkedRing[int]
  
  var head = newDoublyLinkedNode[int](input[0])
  head.next = head
  head.prev = head
  lookup[input[0]] = head
  
  var cur = head

  for i in input[1..^1]: 
    let n = newDoublyLinkedNode[int](i)
    lookup[i] = n
    cur.next = n
    n.next = head
    n.prev = cur
    head.prev = n
    cur = n

  cur = head
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

    var d = lookup[dest]
  
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
  var start = lookup[1]
  var ans: string
  for i in 1 ..< input.len:
    ans = ans & $start.next.value
    start = start.next
  return parseInt(ans)

proc solve2(input:seq[int]): uint64 = 
  var lookup: Table[int, DoublyLinkedNode[int]]
  
  var head = newDoublyLinkedNode[int](input[0])
  head.next = head
  head.prev = head
  lookup[input[0]] = head
  
  var cur = head

  for i in input[1..^1]: 
    let n = newDoublyLinkedNode[int](i)
    lookup[i] = n
    cur.next = n
    n.next = head
    n.prev = cur
    head.prev = n
    cur = n

  for i in 10 .. 1_000_000: 
    let n = newDoublyLinkedNode[int](i)
    lookup[i] = n
    cur.next = n
    n.next = head
    n.prev = cur
    head.prev = n
    cur = n
  
  cur = head # current cup

  for i in 1 .. 10_000_000:

    # pointers to start and end
    var s = cur.next
    var e = s.next.next

    # find destination cup number
    var dest = cur.value - 1
    if dest == 0: dest = 1_000_000
    while dest in [s.value, s.next.value, e.value]: 
      dec(dest)
      if dest == 0: dest = 1_000_000  

    var d = lookup[dest]
  
    # remove 3 picked up values
    cur.next = e.next
    cur.next.prev = cur
    # put back the cups
    d.next.prev = e
    e.next = d.next
    d.next = s
    s.prev = d
    # change current
    cur = cur.next

  cur = lookup[1]
  return uint64(cur.next.value) * uint64(cur.next.next.value)


echo "Answer part 1: ", solve1(input)
echo "Answer part 2: ", solve2(input)
