A = parse.(Int,split(readlines("7.txt")[1], ","))
#A = [16,1,2,0,4,2,7,1,2,14]

# argmin Sum(| f(A) - x |)
function ilovecrabgame(criterion, A)
  x_min = 0
  error_min = typemax(Int64)
  for x in minimum(A):maximum(A)
    error = sum(criterion,abs.(A.-x))
    if error < error_min
      error_min = error
      x_min = x
    end
  end
  return x_min, error_min
end

println(ilovecrabgame(x -> x, A)) # part1, simple addition
println(ilovecrabgame(x-> 0.5 * x * (x+1), A)) # part2 sum_n=1^k(n) = 0.5*k(k+1)