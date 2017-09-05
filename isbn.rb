def check_isbn_length(user_given_isbn)
    # if user_given_isbn[-1] == "x"
    #     user_given_isbn.gsub
    #     check_10_sum(user_given_isbn.split(//))

    # end
    clean_isbn = user_given_isbn.gsub(/[\D]/, "")

    case clean_isbn.length
        when 10
            then check_10_sum(clean_isbn.split(//))
        when 13
            then check_13_sum(clean_isbn.split(//))
    end
end

def check_10_sum(user_given_isbn)
    sum = 0
    
    last_digit = user_given_isbn.pop
        
    if last_digit == "x"
            last_digit = last_digit.to_s
    end
    
    user_given_isbn.each_with_index do |value, index_position|
        sum += ((index_position + 1).to_i * value.to_i)
    end
    
    mod = sum % 11
        if last_digit == "x" && mod == 10
            true
            
        elsif last_digit.to_i == mod.to_i
            true
        else
            false
        end

end

def check_13_sum(user_given_isbn)
    sum = 0

    last_digit = user_given_isbn.pop

    user_given_isbn.each_with_index do |value, index_position|
        if index_position.to_i % 2 == 0
          sum += value.to_i * 1
        else
          sum += value.to_i * 3
        end
    end

    mod = (10 - (sum % 10)) % 10
        if mod == last_digit.to_i
            true
        else
            false
        end

end