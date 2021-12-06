
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


function part2(line_in, num)
  fishes = zeros(Int, 9)

  for x in line_in
    fishes[x+1] += 1
  end

  for d in 1:num
    new_fish = zeros(Int, 9)

    new_fish[9] += fishes[1]
    new_fish[7] += fishes[1]

    for x in 2:9
      new_fish[x-1] += fishes[x]
    end
    fishes = new_fish
  end
  return sum(fishes) 
end

raw_input = parse.(Int, split(readlines("6.txt")[1], ",")) 
@show part2(raw_input, 256)

