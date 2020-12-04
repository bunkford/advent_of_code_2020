import strutils, nre

# put input into seq
proc input(file:string):seq[string] =
  var input: seq[int]
  var data =  file.readFile.split("\n\n")
  return data

var fields = @["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

proc isNumeric(s: string): bool =
  try:
    discard s.parseFloat()
    result = true
  except ValueError:
    result = false

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

proc solve2(input:seq[string]):int =
  var valid = 0
  for x in input:
    var count = 0
    for y in x.findAll(re"(\S+[:]\S+)"):
      if fields.contains(y.split(":")[0]):
        var data = y.split(":")[1]
        case y.split(":")[0]:
          of "byr":
            if data.isNumeric():
              if data.parseInt < 1920 or data.parseInt > 2002:
                continue
            else:
              continue
          of "iyr":
            if data.isNumeric():
              if data.parseInt < 2010 or data.parseInt > 2020:
                continue
            else:
              continue
          of "eyr":
            if data.isNumeric():
              if data.parseInt < 2020 or data.parseInt > 2030:
                continue
            else:
              continue
          of "hgt":
            var height_data =  data.findAll(re"(\d+)|(in|cm)")
            if height_data.len != 2:
              continue
            case height_data[1]:
              of "cm":
                if height_data[0].parseInt < 150 or  height_data[0].parseInt > 193:
                  continue
              of "in":
                if height_data[0].parseInt < 59 or  height_data[0].parseInt > 76:
                  continue

          of "hcl":
            if data.findAll(re"[#0-9a-f]{7}").len != 1:
              continue
   
            
          of "ecl":
            if data.findAll(re"(amb)|(blu)|(brn)|(gry)|(grn)|(hzl)|(oth)").len != 1:
              continue

          of "pid":
            if data.findAll(re"^\d{9}$").len != 1:
              continue
        inc(count)
    if count >= 7:
      inc(valid)
  return valid

     

echo "Answer part 1: ", solve1(input("./aoc_2020_04.txt"))
echo "Answer part 2: ", solve2(input("./aoc_2020_04.txt"))
