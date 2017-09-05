def isbn_dashx(isbn)
    clean_isbn = isbn.delete(" -")

    case clean_isbn.length
        when 10
            then true
        when 13
            then true
    end
end

def check_10_sum(ten_digit_box)
    sum = 0

    clean_isbn = ten_digit_box.scan /\w/
    last_digit = clean_isbn.pop
    
    if last_digit == "x"
        last_digit = last_digit.to_s
    end
    
        clean_isbn.each_with_index do |value, index_position|
        sum += ((index_position + 1).to_i * value.to_i)
    end

    mod = sum % 11
        if last_digit == "x" && mod == 10
            true
            
        elsif last_digit.to_i == mod.to_i
            true
            isbn_true = true
        else
            false
        end
end

def check_13_sum(thirteen_digit_box)
    sum = 0

    clean_isbn = thirteen_digit_box.scan /\w/
    last_digit = clean_isbn.pop

    clean_isbn.each_with_index do |value, index_position|
        if index_position.to_i % 2 == 0
          sum += value.to_i * 1
        else
          sum += value.to_i * 3
        end
    end

    mod = (10 - (sum % 10)) % 10
        if mod == last_digit.to_i
            true
            isbn_true = true
        else
            false
        end
end