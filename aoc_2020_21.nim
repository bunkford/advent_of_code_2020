import strutils, tables, sequtils, sets

proc input(file: string):seq[string] =
  for line in file.lines:
    result.add(line)

proc solve1(input: seq[string]): int =
  var allergens = initTable[string, seq[string]]()
  var occurances = initCounttable[string]()
  for label in input:
    
    for allergen in label.replace(")","").split(" (contains ")[1].split(", "):
        if allergens.hasKey(allergen):
          var trim: seq[string]
          for i in label.replace(")","").split(" (contains ")[0].split(" "):
            if i in allergens[allergen]:
              trim &= @[i]
          allergens[allergen] = trim
        else:
          allergens[allergen] = label.replace(")","").split(" (contains ")[0].split(" ")
        
        allergens[allergen] = allergens[allergen].deduplicate()
    
    # occurances
    for i in label.replace(")","").split(" (contains ")[0].split(" "):
      occurances.inc(i)

  for ingredient, cnt in occurances:
    var found = true
    for allergen, ing in allergens:
        if ingredient in ing: found = false
    if found == true: inc(result, cnt)


echo "Answer part 1: ", solve1(input("./aoc_2020_21.txt"))  # 2262