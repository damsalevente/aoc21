function process(numbers, arr)
 colsum = zeros(15)
 rowsum = zeros(15)
 steps = 1
 answer = 0
 for n in numbers
  c_res = findall(x -> x == n, arr)
  for c in c_res
    colsum[c[2]] += 1
    rowsum[c[1]] += 1
    arr[c] = -1
    if((colsum[c[2]] == 15 ) || (rowsum[c[1]] == 15) )
      answ = sum(filter(x-> x != -1, arr))
      answer = answ * n
      return steps, answer
    end
  end
  steps += 1
 end
  return steps, 0
end

raw_input = readlines("4-900-15.in")

function oneandtwo(raw_input)

  numbers = parse.(Int, split(raw_input[1], ","))

  min_answer = 0
  max_answer = 0

  minstep = length(numbers)
  maxstep = 0

  buffer = Array{Int,2}(undef, (15, 15))
  i = 1
  for idx = 3:length(raw_input)
    arr = parse.(Int16, split(raw_input[idx], " ", keepempty = false))
    if (arr == [])
      s, a = process(numbers, buffer)
      if (s < minstep)
        minstep = s
        min_answer = a
      elseif (s > maxstep)
        maxstep = s
        max_answer = a
      end
      i = 1
    else
      buffer[i, :] = arr
      i += 1
    end
  end
  return (minstep, min_answer), (maxstep, max_answer)
end


@time println(oneandtwo(raw_input))