raw_input = readlines("2.txt")
function first(raw_input)
  cx = 0
  cy = 0
  for line in raw_input
    splits = split(line, " ")
    amount = parse(Int, splits[2])
    println(splits[1])
    if(contains(splits[1], "forward"))
      cx += amount
    end
    if(contains(splits[1], "down"))
      cy += amount
    end
    if(contains(splits[1], "up"))
      cy -= amount
    end
  end
  return cx*cy
end

function second(raw_input)
  cx = 0
  cy = 0
  aim = 0
  for line in raw_input
    splits = split(line, " ")
    amount = parse(Int, splits[2])
    if(contains(splits[1], "forward"))
      cx += amount
      cy += aim * amount
    end
    if(contains(splits[1], "down"))
      aim += amount
    end
    if(contains(splits[1], "up"))
      aim -= amount
    end
  end
  return cx*cy
end

println(first(raw_input))
println(second(raw_input))