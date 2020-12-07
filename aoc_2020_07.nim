import strutils, strscans, tables, sets

proc parseBags(line: string): (string, seq[(string, int)]) =
  var main1, main2, children: string
  if scanf(line, "$w $w bags contain $+.", main1, main2, children):
    result[0] = "$# $#" % [main1, main2]
    if children != "no other bags":
      for c in children.split(", "):
        var n: int
        var colour1, colour2: string
        if scanf(c, "$i $w $w bag", n, colour1, colour2):
          result[1].add ("$# $#" % [colour1, colour2], n)

proc alts(t: TableRef[string, seq[string]], key: string, hSet: var HashSet[string]) =
  if key notin t: return
  for c in t[key]:
    hSet.incl c
    t.alts(c, hSet)

proc solve1(filename:string):int =
  let data = filename.readFile
  var parentColours = newTable[string, seq[string]]()
  for line in data.splitLines:
    let (topColour, childColours) = parseBags(line)
    for (c, i) in childColours:
      if c notin parentColours:
        parentColours[c] = @[topColour]
      else:
        parentColours[c].add topColour
  var a: HashSet[string]
  parentColours.alts("shiny gold", a)
  return a.len


proc bagsInBags(t: TableRef[string, seq[(string, int)]], colour: string): int =
  if colour notin t: return 0
  for (c, i) in t[colour]:
    let nChildren = bagsInBags(t, c)
    if nChildren == 0: result += i
    else: result += i * (nChildren + 1)

proc solve2(filename: string):int =
  let data = filename.readFile
  var children = newTable[string, seq[(string, int)]]()
  for line in data.splitLines:
    let (topColour, childColours) = parseBags(line)
    for (c, i) in childColours:
      if topColour notin children:
        children[topColour] = @[(c, i)]
      else:
        children[topColour].add (c, i)

  return bagsInBags(children, "shiny gold")
  

echo "Answer part 1: ", solve1("./aoc_2020_07.txt")
echo "Answer part 2: ", solve2("./aoc_2020_07.txt")