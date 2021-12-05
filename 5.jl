

function parseinput(raw_input)
  maxval = 0
  lines = []
  for line in raw_input
    p = map(x -> x .+ 1 , [parse.(Int, split(x, ",")) for x in [ y for y in split(line, " -> ")]])
    push!(lines, p)
    maxval = max(maxval, reduce(max,(reduce(max,p))))
  end
  return lines, maxval
end

function overlaps(lines, m_size, with_diag = false)
  field = zeros(Int, (m_size,m_size)) #m_size is the maximum value : a lot of memory for big numbers !!!

  line_straight = filter(x -> x[1][1] == x[2][1] || x[1][2] == x[2][2], lines) # shit
  
  for linenum in 1:length(line_straight)
    ranges = line_straight[linenum]
    ranges = sort(ranges, by= x -> x[1])
    ranges = sort(ranges, by= x -> x[2])

    field[ranges[1][2]:ranges[2][2], ranges[1][1]:ranges[2][1]] .+= 1
  end

  if(with_diag)
    line_diag = filter(x -> abs((x[1][2] - x[2][2]) / (x[1][1] - x[2][1])) == 1 , lines) # shit
    for line = 1:length(line_diag)
      l = line_diag[line] # current line [ [x1,y1], [x2,y2] ]
      # if we up to down or right to left, change the iteration direction in the for loop below
      x_dir = l[1][1] < l[2][1] ? 1 : -1
      y_dir  = l[1][2] < l[2][2] ? 1 : -1
      # for every (x,y) diagonal pair, add +1 
      for (rx, ry) in zip(l[1][1]:x_dir:l[2][1], l[1][2]:y_dir:l[2][2])
        field[ry, rx] += 1
      end
    end
  end
  return count(x -> x .> 1, field)
end

#i/o
raw_input = readlines("5.txt")
lines, maxval = parseinput(raw_input)
# first part  
@time println(overlaps(lines, maxval))
# second part with diag option 
@time println(overlaps(lines, maxval,true))
