require "open-uri"
require "nokogiri"

puts "========================================="
puts "Welcome to your christmas list."
puts "========================================="

gift_list = [{name: "phone", price: 300, marked: false}, {name: "PC", price: 250, marked: false}]

user_action = ""

until user_action == "quit"
	puts "You can [list|add|delete|mark|idea]"
	user_action = gets.chomp

	case user_action
	when "list"
		gift_list.each_with_index do |gift, index|		
			if gift[:marked] == false
				marked = "[ ]"
			else
				marked = "[X]"
			end
			puts "#{index + 1}. #{marked}  #{gift[:name]} $#{gift[:price]}"
		end		
	when "add"
		puts "What gift?"
		gift_name = gets.chomp
		puts "What is the price?"
		gift_price = gets.chomp
		puts "========================================"	
		gift_list << {name: gift_name, price: gift_price}
	when "delete"
		puts "What gift do you want to remove from the gift list?"
		gift_index = gets.chomp.to_i - 1
		gift_list.delete_at(gift_index)				
	when "mark"
		puts "What gift do you want to mark as bought?"
		gift_index = gets.chomp.to_i - 1
		gift_list[gift_index][:marked] = true
	when "idea"
		url="https://www.etsy.com/search?q=cake"
		response = open(url).read
		html_doc = Nokogiri::HTML(response)
		etsy_gifts = [{name: "asfasf", price: 33}]

		html_doc.search('.v2-listing-card_info') do |element|
			# etsy_name = element.search('.text-body').text.strip
			etsy_name = element.search('.text-body').text.strip
			etsy_price = element.search('.currency-value').text.strip.to_i
			etsy_gifts << {name: etsy_name, price: etsy_price, marked: false}
		end
		etsy_gifts.each_with_index do |gift, index|		
			puts "#{index + 1}. #{gift[:name]} $#{gift[:price]}" 
		end		

		puts "Pick one to add to your list (give the number)"
	    gift_index = gets.chomp.to_i - 1
		gift_list << etsy_gifts[gift_index]
	end
end