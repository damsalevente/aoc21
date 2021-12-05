raw_input = readlines("5.txt")

lines = []

maxval = 0
for line in raw_input
  p = split(line, " -> ")
  if length(p) < 2
    continue
  end

  p1 = parse.(Int, split(p[1], ","))
  p2 = parse.(Int, split(p[2], ","))
  p1[1] += 1
  p1[2] += 1
  p2[1] += 1
  p2[2] += 1
  _m1 = max(p1[1], p1[2])  # shit 
  _m2 = max(p2[1], p2[2]) 
  global maxval = max(maxval, _m1, _m2)
  push!(lines, [p1, p2])
end
  
lines = reshape(lines, (:,2))

function overlaps(lines, m_size, with_diag = false)
  answer = 0
  field = zeros(Int, (m_size,m_size))
  hor_or_diag = filter(x -> x[1][1] == x[2][1] || x[1][2] == x[2][2], lines) # shit
  if with_diag
    onlydiag = filter(x -> abs((x[1][2] - x[2][2]) / (x[1][1] - x[2][1])) == 1 , lines) # shit
  end
  
  for linenum in 1:length(hor_or_diag)
    ranges = copy(hor_or_diag[linenum])
    ranges = sort(ranges, by= x -> x[1])
    ranges = sort(ranges, by= x -> x[2])

    field[ranges[1][2]:ranges[2][2], ranges[1][1]:ranges[2][1]] .+= 1
  end

  if with_diag
  for line = 1:length(onlydiag)
    range = onlydiag[line]
    r1 = 1
    r2 = 1
    if(range[1][1] > range[2][1])
      r1 = -1
    end
    if(range[1][2] > range[2][2])
      r2 = -1
    end
    for (rx, ry) in zip(range[1][1]:r1:range[2][1], range[1][2]:r2:range[2][2])
      field[ry, rx] += 1
    end
  
  
  end
end
  answer = sum(count.(x -> x > 1, field))
  return answer
end

  
println(overlaps(lines, maxval))
println(overlaps(lines, maxval,true)) # with diag
println(maxval)
