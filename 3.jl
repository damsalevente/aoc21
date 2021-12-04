raw_input = readlines("3.txt")

function first(raw_input)
  thresh = length(raw_input) / 2 
  wordsize = length(raw_input[1])

  c = zeros(wordsize)  # count the occurences of ones
  s_eps = fill('0',wordsize)
  s_gamma = fill('1', wordsize) 

  for numbers in raw_input
    for idx in 1:length(c)
      if(numbers[idx] == '1')
        c[idx] += 1
        if(c[idx] > thresh)
          s_eps[idx] = '1'
          s_gamma[idx] = '0'
          break
        end
      end
    end
  end
  eps = parse(Int64, String(s_eps),base= 2)
  delta = parse(Int64, String(s_gamma), base =2)
  return eps * delta
end

function filterby(filtered, mostorleast, wordsize)
  #=
    count the '1's in the array, if mostorleast is 1, fill the original value with 0-s and get 1's if there are more than half

    filtered: original array of strings
    mostorleast: if most, the counted one's will be written, else 0 will be the value for each bit
  =#
  s = fill('0', wordsize)
  if (mostorleast == '0')
    s = fill('1', wordsize)
  end
  for idx = 1:wordsize
    count = 0
    for element in filtered
      if (element[idx] == '1')
        count += 1
      end
    end
    if (length(filtered) == 1)
      s[idx] = Char(count + '0')
    elseif (count >= length(filtered) / 2)
      s[idx] = mostorleast
    end
    filtered = filter(x -> x[idx] == s[idx], filtered)
  end
  return s
end

function second(raw_input)
  s_len = length(raw_input[1])
  val1 = filterby(raw_input, '1', s_len)
  val2 = filterby(raw_input, '0', s_len)
  val1 = parse(Int64, String(val1),base=2 )
  val2 = parse(Int64, String(val2), base = 2)
  return val1 * val2
end


@time println(first(raw_input))
@time println(second(raw_input))