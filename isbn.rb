def empty_array
    []
end

def isbn_length(isbn)
    if isbn.length == 10
        true
    elsif isbn.length == 13
        true
    else
        false
    end
end 

def isbn_dashx(isbn)
    clean_isbn = isbn.delete(" -")

    case clean_isbn.length
        when 10
            then true
        when 13
            then true
    end
end

def check_sum(isbn)
    sum = 0

    clean_isbn = isbn.scan /\w/
    last_digit = clean_isbn.pop
    
    if last_digit == "x"
            last_digit = last_digit.to_s
    end
    
        clean_isbn.each_with_index do |value, index_position|
        sum = sum + ((index_position + 1).to_i * value.to_i)
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