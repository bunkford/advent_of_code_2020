import strutils, sequtils, nre

proc input(file: string):seq[string] =
  for line in file.lines:
    result.add(line)

proc solve_no_bracket(question: string):BiggestInt =
  var q = question.split(" ")
  while q.count("*") + q.count("+") > 0:
      var new_question:string
      case q[1]:
        of "+":
          new_question = $(q[0].parseBiggestInt + q[2].parseBiggestInt)
        of "*":
          new_question = $(q[0].parseBiggestInt * q[2].parseBiggestInt)
      for i in 3 .. q.high:
        new_question = new_question & " " & q[i]
      q = new_question.split(" ")

  result = q[0].parseBiggestInt

proc solve1(input:seq[string]):BiggestInt = 
  for question in input:
    var q = question.split(" ")
    if q.join(" ").count("(") + q.join(" ").count(")") == 0:
      result += solve_no_bracket(q.join(" "))
    else:
      while q.join(" ").findAll(re"\(([0-9]|\*|\+|\s)*\)").len > 0:
        q = q.join(" ").replace(re"\(([0-9]|\*|\+|\s)*\)", proc (match:string):string = $solve_no_bracket(match[1..^2])).split(" ")

      if q.join(" ").count("(") + q.join(" ").count(")") == 0:
        result += solve_no_bracket(q.join(" "))


echo "Answer part 1: ", solve1(input("./aoc_2020_18.txt"))