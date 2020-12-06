import strutils, sequtils

var people:seq[int]
var input_unmoded:seq[string]
proc input(file: string):seq[string] =
  var r = file.readFile.split("\n\n")
  for i in r:
    people.add(i.count("\n") + 1)
  r.applyIt(it.replace("\n", ""))
  return r


proc solve1(input:seq[string]):int =
  var r: int
  for group in input:
    inc(r, group.toSeq.deduplicate.len)
  return r

proc solve2(input:seq[string]):int =
  var r: int
  var last = r
  for key, group in input:
    if group.count("a") == people[key]: inc(r)
    if group.count("b") == people[key]: inc(r)
    if group.count("c") == people[key]: inc(r)
    if group.count("d") == people[key]: inc(r)
    if group.count("e") == people[key]: inc(r)
    if group.count("f") == people[key]: inc(r)
    if group.count("g") == people[key]: inc(r)
    if group.count("h") == people[key]: inc(r)
    if group.count("i") == people[key]: inc(r)
    if group.count("j") == people[key]: inc(r)
    if group.count("k") == people[key]: inc(r)
    if group.count("l") == people[key]: inc(r)
    if group.count("m") == people[key]: inc(r)
    if group.count("n") == people[key]: inc(r)
    if group.count("o") == people[key]: inc(r)
    if group.count("p") == people[key]: inc(r)
    if group.count("q") == people[key]: inc(r)
    if group.count("r") == people[key]: inc(r)
    if group.count("s") == people[key]: inc(r)
    if group.count("t") == people[key]: inc(r)
    if group.count("u") == people[key]: inc(r)
    if group.count("v") == people[key]: inc(r)
    if group.count("w") == people[key]: inc(r)
    if group.count("x") == people[key]: inc(r)
    if group.count("y") == people[key]: inc(r)
    if group.count("z") == people[key]: inc(r)
    last = r
  return r


echo "Answer part 1: " , solve1(input("./aoc_2020_06.txt"))
echo "Answer part 2: " , solve2(input("./aoc_2020_06.txt"))