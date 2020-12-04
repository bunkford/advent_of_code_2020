import strutils, nre

# put input into seq
proc input(file:string):seq[string] =
  var input: seq[int]
  var data =  file.readFile.split("\n\n")
  return data

var fields = @["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

proc solve1(input:seq[string]):int = 
  var valid = 0
  for x in input:
    var count = 0
    for y in x.findAll(re"(\S+[:]\S+)"):
      if fields.contains(y.split(":")[0]):
        inc(count)
    if count >= 7:
      inc(valid)
  return valid


echo "Answer part 1: ", solve1(input("./aoc_2020_04.txt"))