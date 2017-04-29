class Hangman
	attr_accessor :name, :guess
	def initilize(password_name)
			@name = password_name
		end
		def charcount
			name.length
		end
		def blank
			Array.new(charcount,"_")
		end
		def correct_letter(letter)
			name.include?(letter)
		end
		def update_guessed(choice)
			guessed.push(choice)
		end
		def correct_index(choice)
			password=name.split("")
			p choice
			p password
			password.each_with_index do |letter, index_position|
				if letter == choice
					correct_blank[index_position] = choice
				end
			end
		end
		def already_guessed(choice)
			if guessed.count(choice) == 0
				true
			else
				false
			end
		end
		
			
		end

end