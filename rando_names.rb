def pairing(name)
  # array_of_names = []
  # array_of_names << name
  pairs = name.shuffle.each_slice(2).to_a
    if name.length % 2 == 0
    else
      last_one = pairs.pop
      last_one = last_one[0]
      pairs[0] << last_one
    end
    pairs.map! {|name1, name2, name3| "#{name1} " "#{name2} " "#{name3}"}.join" and "
end