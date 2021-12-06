
function solve(original_in,num )
  data = copy(original_in)
  for i in 1:num
    original_in .-= 1
    n_zeros = count(x -> x == -1, original_in)
    append!(original_in, ones(n_zeros) .* 8)
    original_in[original_in.==-1] .= 6
  end
  return length(original_in)
end


#=
# 1
# 0
# 6 7
#
=#
function part2(line_in, num)
  # init -> 0 -> grow
  # 0 -> 6 downto 0 to grow
  # 8 -> 0 -> 6 
  x_80 = 0
  idx = 1
  for element in line_in
    to = num - element
    spawn_times = idx + 8:6:to 
    while(idx != to)
      x_80 += length(spawn_times)
      spawn_times = idx + 8:6:to
    end
  end
  return x_80 
  
end

raw_input = parse.(Int, split(readlines("6.txt")[1], ",")) 
println(solve(raw_input, 80))
println(trunc(Int, part2(raw_input, 80)))

