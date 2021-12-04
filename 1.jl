
function second(meas)
  count = 0
  for index = 1:length(meas)-3
    now = meas[index]
    next = meas[index+3]
    if (next > now)
      count += 1
    end
  end
  return count
end
  
function merged_lambda(meas, x)
  return count(x -> x[1] < x[2], collect(zip(meas[1:1:end-x],append!(meas[x+1:1:end], zeros(x))))) 
end

meas = [parse(Int64, x) for x in readlines("aoc/1.txt")]

println(merged_lambda(meas, 2))
println(merged_lambda(meas, 3))
# vedes -> tervet osszerakunk erre a felevre