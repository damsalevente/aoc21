
raw_input = readlines("8.txt")

# part1 was just a length() check and sum

function part2(raw_input)
  result = 0

  for line in raw_input
    # pattern1 pattern2 pattern3 | digit1 digit2 digit3
    patterns = split(line, "|")[1]
    digits = split(line, "|")[2]

    # count every segment's occurence
    charcounts = Dict{Char, Int}()
    for ch in "abcdefg"
      c = count(x -> x == ch, patterns)
      charcounts[ch] = c
    end

    patterns = [x for x in split(patterns," ")]

    seven = Set(filter(x -> length(x) == 3 , patterns)[1])
    one = Set(filter(x -> length(x) == 2, patterns)[1])
    four = Set(filter( x -> length(x) == 4, patterns)[1])

    # build the enocder based on some stupid adhoc rules 
    # 1 is seven without the hat, so get the unique value
    seg_top = collect(setdiff(seven, one))[1]
    # bottom right occurs seven times 
    seg_bot_r =  collect(keys(filter((kv) -> kv.second == 9, charcounts)))[1]  
    # occurs 8 times and not the top one 
    seg_top_r = collect(keys(filter((kv) -> kv.second == 8 && in(kv.first,  seg_top) == false, charcounts)))[1] 
    # occurs seven times and number four doesn't contain it 
    seg_bot = collect(keys(filter((kv) -> kv.second == 7 && in(kv.first,  four) == false, charcounts)))[1] 
    # occurs seven times, and not the bot character
    seg_mid = collect(keys(filter((kv) -> kv.second == 7 && in(kv.first,  seg_bot) == false, charcounts)))[1] 
    # unique number of occurences
    seg_top_l = collect(keys(filter((kv) -> kv.second == 6, charcounts)))[1]
    # unique number of occurences
    seg_bot_l = collect(keys(filter((kv) -> kv.second == 4, charcounts)))[1]


    # now the segment's position is known, let's build the Decoder table with a set as key
    Decoder = Dict{Set, Char}()

    Decoder[Set([seg_top, seg_top_r, seg_top_l,  seg_bot_r, seg_bot_l, seg_bot])] = '0'
    Decoder[Set([seg_top_r, seg_bot_r])] = '1'
    Decoder[Set([seg_top, seg_top_r, seg_mid, seg_bot_l, seg_bot])] = '2'
    Decoder[Set([seg_top, seg_top_r, seg_mid, seg_bot_r, seg_bot])] = '3'
    Decoder[Set([seg_top_l, seg_top_r, seg_mid, seg_bot_r])] = '4'
    Decoder[Set([seg_top, seg_top_l, seg_mid, seg_bot_r, seg_bot])] = '5'
    Decoder[Set([seg_top, seg_top_l, seg_mid, seg_bot_r, seg_bot_l,  seg_bot])] = '6'
    Decoder[Set([seg_top_r, seg_bot_r, seg_top])] = '7'
    Decoder[Set([seg_top, seg_top_r, seg_top_l,  seg_bot_r, seg_bot_l, seg_bot, seg_mid])] = '8'
    Decoder[Set([seg_top, seg_top_r, seg_top_l,  seg_bot_r, seg_bot, seg_mid])] = '9'

    #  Decode every number and create a character array from them
    curnum = map(x -> Decoder[Set(x)], split(digits, " ", keepempty = false))

    val = parse(Int, String(curnum))
    result += val
  end
  return result
end

@time println(part2(raw_input))