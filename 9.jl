function part1(raw_input)
  lenx = length(raw_input)
  leny = length(raw_input[1])
  mins = []
  mtx = Array{Int, 2}(undef,(lenx,leny))
  for i in 1:lenx
    for j in 1:leny
      mtx[i,j] = parse(Int, raw_input[i][j])
    end
  end

  for x in 1:lenx
    for y in 1:leny
      xrange1 = max(x-1,1)
      xrange2 = min(x+1, lenx)
      yrange1 = max(y-1, 1)
      yrange2 = min(y+1, leny)
      if mtx[x,y] == minimum(mtx[xrange1:xrange2,yrange1:yrange2])
        push!(mins, mtx[x,y])
      end
    end
  end
  return sum([x+1 for x in mins])
end


println(part1(readlines("9.txt")))
