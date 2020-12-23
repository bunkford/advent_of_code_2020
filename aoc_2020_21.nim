import strutils, tables, sequtils, algorithm

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

proc solve2(input:seq[string]):string =
  var allergens = initTable[string, seq[string]]()
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

  var used:seq[string]
  while true:
    for allergen, ingredients in allergens:
      if ingredients.len == 1 and ingredients[0] notin used:
        used.add(ingredients[0])
      elif ingredients.len > 1:
        for i in used:
          if i in ingredients:
            allergens[allergen].keepItIf(it != i)
    
    var stop: bool = false
    for v in allergens.values():
      if v.len > 1: stop = true
    if stop == false: break
  
  var sorted:seq[string]
  for k in allergens.keys():
    sorted.add(k)
  
  for k in sorted.sorted():
    result = result & allergens[k][0] & ","
  
  return result[0..^2]

echo "Answer part 1: ", solve1(input("./aoc_2020_21.txt")) 
echo "Answer part 2: ", solve2(input("./aoc_2020_21.txt")) 