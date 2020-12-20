import strutils, tables, nre

proc input(file: string):(Table[int, string], seq[string]) =
  for line in file.lines:
    if line != "":
      if line[0].isDigit: # rule
        var rule_num = line.split(": ")[0].parseInt
        var rule = line.split(": ")[1]
        result[0][rule_num] = rule
      else:  # message
        result[1].add(line)

proc build_rule(rules: Table[int, string], rule_id: int): seq[string] =
  if rules[rule_id].contains("|"):
    result.add("(")
    var halves = rules[rule_id].split(" | ")
    if $rule_id in rules[rule_id].split(" "):
      result.add("?P<g" & $rule_id & ">")
    for half in halves:
      for i in half.split(" "):
        if $rule_id == i:
          result.add("(?P>g" & $rule_id & ")*")
        else:
          result.add(build_rule(rules, i.parseInt))
      result.add("|")
    discard result.pop()
    result.add(")")
    return result
  elif rules[rule_id].contains("\""):
    return @[rules[rule_id].strip(chars = {'"'})]
  else:
    for i in rules[rule_id].split():
      result.add(build_rule(rules, i.parseInt))
    return result  

proc solve1(input: (Table[int, string], seq[string])):int = 
  var rules = input[0]
  var messages = input[1]
  var regex = re("^" & build_rule(rules, 0).join() & "$")
  for m in messages:
    var match = m.match(regex)
    if match.isNone == false:
      inc(result)

proc solve2(input: (Table[int, string], seq[string])):int = 
  var rules = input[0]
  rules[8] = "42 | 42 8"
  rules[11] = "42 31 | 42 11 31"
  var messages = input[1]
  var regex = re("^" & build_rule(rules, 0).join() & "$")
  for m in messages:
    var match = m.match(regex)
    if match.isNone == false:
      inc(result)

echo "Answer Part 1: ", solve1(input("./aoc_2020_19.txt"))
echo "Answer Part 2: ", solve2(input("./aoc_2020_19.txt"))