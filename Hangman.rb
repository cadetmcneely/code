class Hangman
	attr_accessor :name, :guessed, :correct_blank, :counter
	def initialize(password_name)
		@name = password_name.upcase
		@guessed = []
		@correct_blank = blank()
		@counter = 8
	end
	def charcount

		name.length
	end
	
	def blank()

		Array.new(charcount, "_")
	end
	def correct_letter(letter)

		name.include?(letter)
	end
	def update_guessed(choice)

		guessed.push(choice)
	end
	def correct_index(guessletter)
		password=name.split("")
		p guessletter
		p password
		password.each_with_index do |letter, index_position|
			p letter
			if letter == guessletter
				correct_blank[index_position] = guessletter
			end
		end
	end
	def available_guess(choice)
	
	if	guessed.include?(choice)
			false
		else
			true
		end
	end
	def make_move(choice)
		if correct_letter(choice) == true
			correct_index(choice)
		else
			@counter -=1
		end
	end
	def loser
		@counter == 0
	end
	def winner
		if correct_blank.include?("_")
			false
		else
			true
		end
end
end