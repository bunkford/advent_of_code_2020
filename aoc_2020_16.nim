import strscans, strutils, sequtils, tables

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
        if code >= rule.from1 and code <= rule.to1 or code >= rule.from2 and code <= rule.to2:
          # code matches a rule
          inc(match)
          break 
      if match == 0: wrong_inputs.add(code)
  
  return wrong_inputs.foldl(a+b)
      

proc solve2(input:(seq[Rule], seq[int], seq[seq[int]])):int64 =
  result = 1
  var rules = input[0]
  var your_ticket = input[1]
  var near_by = input[2]
  var good_tickets:seq[seq[int]]
  
  # get a seq of good tickets
  for ticket in near_by:
    var good: bool = true
    for code in ticket:
      var match: int
      for rule in rules:
        if (code >= rule.from1 and code <= rule.to1) or (code >= rule.from1 and code <= rule.to2):
          # code matches a rule
          inc(match)
          break 
      if match == 0: good = false
    if good:
      good_tickets.add(ticket)

  # create a list of every position that the code doesn't fit
  var ni = initTable[string, seq[int]]()
  for ticket_number, ticket in good_tickets:
    for code_number, code in ticket:
      var match: int
      for rule_number, rule in rules:
        if code >= rule.from1 and code <= rule.to1 or code >= rule.from2 and code <= rule.to2:
          discard
        else:
          # rule.field  is not in location code_number
          if ni.hasKeyOrPut(rule.field, @[code_number]):
            ni[rule.field].add(code_number)
  

  # sort the list by length from high to low, then you can deduce the order by process of elimination
  # if rule contains departure, multiply it by the result
  var pos:seq[int]
  for i in 0..rules.high: 
    pos.add(i)
  var s = pos
  while pos.len > 1:
    for k, v in ni:
      if v.len == pos[^1]:
        var z = s
        for p, i in z:
          if i notin v:
            s.delete(p)
            pos.delete(pos.high)
            if k.contains("departure"):
              result *= your_ticket[i]
        break


echo "Answer part 1: ", solve1(input("./aoc_2020_16.txt"))
echo "Answer part 2: ", solve2(input("./aoc_2020_16.txt"))