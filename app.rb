require 'sinatra'
require_relative 'Hangman.rb'
enable :sessions

get '/' do
	erb :index
end 
	post '/player_names' do 
		player1 = params[:player1]
		player2 = params[:player2]
		"Player 1 is #{player1} and Player 2 is #{player2}"
		redirect '/password?player1=' + player1 + '&player2=' + player2
	end
	get '/password' do
		player1 = params[:player1]
		player2 = params[:player2]
		erb :password, locals: {p1_name: player1, p2_name: player2}
	end	
	post '/secretword' do
		password = params[:word]
		session[:game] = Hangman.new(password)
		player1 = params[:player1]
		player2 = params[:player2]
			"Player 1 is #{session[:player1]} and player 2 is #{session[:player2]}. your word is #{:password}"	
		redirect '/guessing'
	end
	get '/guessing' do
		erb :guessing, locals:{p1_name: session[:player1], p2_name: session[:player2], blank: session[:game].correct_blank, message: "Pick a letter..", array: session[:game].guessed, counter: session[:game].counter}
	end
	post '/guess' do
		player1 = params[:player1]
		player2 = params[:player2]
		choice = params[:letter].upcase
			if session[:game].available_guess(choice)
				true
				session[:game].update_guessed(choice)
				session[:game].make_move(choice)
					if session[:game].loser == true
						redirect 'loser'
					end
			elsif session[:game].available_guess(choice)
				true
				session[:game].update_guessed(choice)
				session[:game].make_move(choice)
					if session[:game].winner == true
						redirect 'winner'
					end 
					redirect '/guessing'
			else
				
			 	redirect 'guessing?player1=' + player1 + '&player2' + player2
			
		erb :guessing, locals:{p1_name: session[:player1], p2_name: session[:player2], blank: session[:game].correct_blank, message: "Try again!", array: session[:game].guessed, counter: session[:game].counter}
			
	end

	get '/loser' do
		erb :loser, locals: {p1_name: session[:player1], p2_name: session[:player2]}
	end
	get '/winner' do
	 	erb :winner, locals:{p1_name: session[:player1], p2_name: session[:player2]}
	end
end