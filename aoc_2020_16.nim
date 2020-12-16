import strscans, strutils, sequtils

type
  Rule = object
    field: string
    from1: int
    to1: int
    from2:int
    to2:int

proc input(filename: string):(seq[Rule], seq[int], seq[seq[int]]) = # (rules, your_ticket, near_by)
  var your_ticket:seq[int]
  var yt:bool = false
  
  var near_by:seq[seq[int]]
  var nb:bool = false

  var rules: seq[Rule]
  for line in filename.lines:
    var field:string
    var f1, t1, f2, t2: int
    if line.scanf("$*: $i-$i or $i-$i", field, f1, t1, f2, t2):
      rules.add(Rule(field: field, from1: f1, to1: t1, from2: f2, to2: t2))

    if line == "your ticket:": 
      yt = true 
      continue
    if yt: 
      your_ticket = line.split(",").map(parseInt)
      yt = false

    if line == "nearby tickets:": 
      nb = true
      continue
    if nb:
      echo line
      near_by.add(line.strip(chars = {char(0)}).split(",").map(parseInt))

  return (rules, your_ticket, near_by)


proc solve1(input:(seq[Rule], seq[int], seq[seq[int]])):int =
  var rules = input[0]
  var your_ticket = input[1]
  var near_by = input[2]
  var wrong_inputs:seq[int]
  for ticket in near_by:
    for code in ticket:
      var match: int
      for rule in rules:
        if code >= rule.from1 and code <= rule.to1 or code >= rule.from1 and code <= rule.to2:
          # code matches a rule
          inc(match)
          break 
      if match == 0: wrong_inputs.add(code)
  
  return wrong_inputs.foldl(a+b)
      





echo "Answer part 1: ", solve1(input("./aoc_2020_16.txt")) 