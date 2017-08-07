def coin_changer(cents_given_to_me)
  coin_value = {quarter: 25, dime: 10, nickel: 5, penny: 1}
  coins_given_to_customer = {quarter: 0, dime: 0, nickel: 0, penny: 0}

  coin_value.each do |individual_coins, worth_of_coins|
    while cents_given_to_me.to_i >= worth_of_coins.to_i
      cents_given_to_me = cents_given_to_me.to_i - worth_of_coins.to_i
      coins_given_to_customer[individual_coins] += 1
    end
  end
  coins_given_to_customer.to_s
end

# def hash_converter(coins_given_to_customer)
# 	change = " "
# 	coins_given_to_customer.length do |key, value|
# 		if value > 0
# 		  change << " " + value.to_s + " " + key.to_s + "s"
# 	  end
# 	end
# 	change.to_s
# end