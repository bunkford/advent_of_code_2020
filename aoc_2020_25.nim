var card_pk = 12092626
var door_pk = 4707356

# Test data
#var card_pk = 5764801
#var door_pk = 17807724

proc crackLoop(pk: int): int =
  var x = 7
  var loop_size = 1
  while x != pk:
      x = (x * 7) mod 20201227
      inc(loop_size)
  return loop_size

proc transform(subj: int, loop:int): uint64 =
  var v:uint64 = 1
  for i in 0 ..< loop:
    v = (v * uint64 subj) mod 20201227
  return uint64 v

let cardKey = crackLoop(card_pk)
let exchKey = transform(door_pk, cardKey)
echo exchKey
