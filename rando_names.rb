def pairing(array_names)
  pairs = array_names.shuffle.each_slice(2).to_a
    if array_names.length % 2 == 0
    else
      last_one = pairs.pop
      last_one = last_one[0]
      pairs[0] << last_one
    end
    pairs
end

# double check variable names here with names in functions, 
#see if you can get those names into an array,
# and then find a code to take them out of an array