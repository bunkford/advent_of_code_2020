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

proc solve1_alt(file:string):int =
  # pure regex
  return file.readFile.findAll(re"((((byr):([^ \n]*))|((iyr):([^ \n]*))|((eyr):([^ \n]*))|((hgt):([^ \n]*))|((hcl):([^ \n]*))|((ecl):([^ \n]*))|((pid):([^ \n]*))))( |\n)((cid):([^ \n]*)( |\n)){0,1}(?!(\4|\7|\10|\13|\16|\19|\22))((((byr):([^ \n]*))|((iyr):([^ \n]*))|((eyr):([^ \n]*))|((hgt):([^ \n]*))|((hcl):([^ \n]*))|((ecl):([^ \n]*))|((pid):([^ \n]*))))( |\n)((cid):([^ \n]*)( |\n)){0,1}(?!(\4|\7|\10|\13|\16|\19|\22|\33|\36|\39|\42|\45|\48|\51))((((byr):([^ \n]*))|((iyr):([^ \n]*))|((eyr):([^ \n]*))|((hgt):([^ \n]*))|((hcl):([^ \n]*))|((ecl):([^ \n]*))|((pid):([^ \n]*))))( |\n)((cid):([^ \n]*)( |\n)){0,1}(?!(\4|\7|\10|\13|\16|\19|\22|\33|\36|\39|\42|\45|\48|\51|\62|\65|\68|\71|\74|\77|\80))((((byr):([^ \n]*))|((iyr):([^ \n]*))|((eyr):([^ \n]*))|((hgt):([^ \n]*))|((hcl):([^ \n]*))|((ecl):([^ \n]*))|((pid):([^ \n]*))))( |\n)((cid):([^ \n]*)( |\n)){0,1}(?!(\4|\7|\10|\13|\16|\19|\22|\33|\36|\39|\42|\45|\48|\51|\62|\65|\68|\71|\74|\77|\80|\91|\94|\97|\100|\103|\106|\109))((((byr):([^ \n]*))|((iyr):([^ \n]*))|((eyr):([^ \n]*))|((hgt):([^ \n]*))|((hcl):([^ \n]*))|((ecl):([^ \n]*))|((pid):([^ \n]*))))( |\n)((cid):([^ \n]*)( |\n)){0,1}(?!(\4|\7|\10|\13|\16|\19|\22|\33|\36|\39|\42|\45|\48|\51|\62|\65|\68|\71|\74|\77|\80|\91|\94|\97|\100|\103|\106|\109|\120|\123|\126|\129|\132|\135|\138))((((byr):([^ \n]*))|((iyr):([^ \n]*))|((eyr):([^ \n]*))|((hgt):([^ \n]*))|((hcl):([^ \n]*))|((ecl):([^ \n]*))|((pid):([^ \n]*))))( |\n)((cid):([^ \n]*)( |\n)){0,1}(?!(\4|\7|\10|\13|\16|\19|\22|\33|\36|\39|\42|\45|\48|\51|\62|\65|\68|\71|\74|\77|\80|\91|\94|\97|\100|\103|\106|\109|\120|\123|\126|\129|\132|\135|\138|\149|\152|\155|\158|\161|\164|\167))((((byr):([^ \n]*))|((iyr):([^ \n]*))|((eyr):([^ \n]*))|((hgt):([^ \n]*))|((hcl):([^ \n]*))|((ecl):([^ \n]*))|((pid):([^ \n]*))))").len
proc solve2_alt(file:string):int =
  # pure regex
  return file.readFile.findAll(re"((((byr):(19[2-9]\d|200[0-2]))|((iyr):(201\d|2020))|((eyr):(202\d|2030))|((hgt):(1[5-8]\dcm|19[0-3]cm|59in|6\din|7[0-6]in))|((hcl):(#[0-9a-f]{6}))|((ecl):(amb|blu|brn|gry|grn|hzl|oth))|((pid):([\d]{9}))))( |\n)((cid):([^ \n]*)( |\n)){0,1}(?!(\4|\7|\10|\13|\16|\19|\22))((((byr):(19[2-9]\d|200[0-2]))|((iyr):(201\d|2020))|((eyr):(202\d|2030))|((hgt):(1[5-8]\dcm|19[0-3]cm|59in|6\din|7[0-6]in))|((hcl):(#[0-9a-f]{6}))|((ecl):(amb|blu|brn|gry|grn|hzl|oth))|((pid):([\d]{9}))))( |\n)((cid):([^ \n]*)( |\n)){0,1}(?!(\4|\7|\10|\13|\16|\19|\22|\33|\36|\39|\42|\45|\48|\51))((((byr):(19[2-9]\d|200[0-2]))|((iyr):(201\d|2020))|((eyr):(202\d|2030))|((hgt):(1[5-8]\dcm|19[0-3]cm|59in|6\din|7[0-6]in))|((hcl):(#[0-9a-f]{6}))|((ecl):(amb|blu|brn|gry|grn|hzl|oth))|((pid):([\d]{9}))))( |\n)((cid):([^ \n]*)( |\n)){0,1}(?!(\4|\7|\10|\13|\16|\19|\22|\33|\36|\39|\42|\45|\48|\51|\62|\65|\68|\71|\74|\77|\80))((((byr):(19[2-9]\d|200[0-2]))|((iyr):(201\d|2020))|((eyr):(202\d|2030))|((hgt):(1[5-8]\dcm|19[0-3]cm|59in|6\din|7[0-6]in))|((hcl):(#[0-9a-f]{6}))|((ecl):(amb|blu|brn|gry|grn|hzl|oth))|((pid):([\d]{9}))))( |\n)((cid):([^ \n]*)( |\n)){0,1}(?!(\4|\7|\10|\13|\16|\19|\22|\33|\36|\39|\42|\45|\48|\51|\62|\65|\68|\71|\74|\77|\80|\91|\94|\97|\100|\103|\106|\109))((((byr):(19[2-9]\d|200[0-2]))|((iyr):(201\d|2020))|((eyr):(202\d|2030))|((hgt):(1[5-8]\dcm|19[0-3]cm|59in|6\din|7[0-6]in))|((hcl):(#[0-9a-f]{6}))|((ecl):(amb|blu|brn|gry|grn|hzl|oth))|((pid):([\d]{9}))))( |\n)((cid):([^ \n]*)( |\n)){0,1}(?!(\4|\7|\10|\13|\16|\19|\22|\33|\36|\39|\42|\45|\48|\51|\62|\65|\68|\71|\74|\77|\80|\91|\94|\97|\100|\103|\106|\109|\120|\123|\126|\129|\132|\135|\138))((((byr):(19[2-9]\d|200[0-2]))|((iyr):(201\d|2020))|((eyr):(202\d|2030))|((hgt):(1[5-8]\dcm|19[0-3]cm|59in|6\din|7[0-6]in))|((hcl):(#[0-9a-f]{6}))|((ecl):(amb|blu|brn|gry|grn|hzl|oth))|((pid):([\d]{9}))))( |\n)((cid):([^ \n]*)( |\n)){0,1}(?!(\4|\7|\10|\13|\16|\19|\22|\33|\36|\39|\42|\45|\48|\51|\62|\65|\68|\71|\74|\77|\80|\91|\94|\97|\100|\103|\106|\109|\120|\123|\126|\129|\132|\135|\138|\149|\152|\155|\158|\161|\164|\167))((((byr):(19[2-9]\d|200[0-2]))|((iyr):(201\d|2020))|((eyr):(202\d|2030))|((hgt):(1[5-8]\dcm|19[0-3]cm|59in|6\din|7[0-6]in))|((hcl):(#[0-9a-f]{6}))|((ecl):(amb|blu|brn|gry|grn|hzl|oth))|((pid):([\d]{9}))))").len

echo "Answer part 1: ", solve1(input("./aoc_2020_04.txt"))
echo "Answer part 2: ", solve2(input("./aoc_2020_04.txt"))

echo "Answer part 1 (pure regex): ", solve1_alt("./aoc_2020_04.txt")
echo "Answer part 2 (pure regex): ", solve2_alt("./aoc_2020_04.txt")