require_relative 'board'
require_relative 'player'

class Game
	attr_accessor :board

	VALID_CHARS = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',
		'1', '2', '3', '4', '5', '6', '7', '8']	

	def initialize
		@board = Board.new
		@file = %w[a b c d e f g h]
		@player_one = Player.new(:white)
		@player_two = Player.new(:black)
		@current_player = @player_one
	end

	def play_game				
		game_setup
		print_piece_input
		binding.pry										
	end

	def game_setup
		print_welcome_message
		print_select_game_type							
	end	

	def print_welcome_message
		puts "\nWelcome to Chess! This is a two-player, console-based game that follows "\
		"traditional chess rules without time limitations.\n"
	end

	def print_select_game_type
		puts "Would you like to:\n\n[1] Start a new game\n[2] Load a saved game\n"
		@game_input = gets.chomp
		print_piece_input 
	end

	def print_piece_input
		if @game_input == "1"		
			@board.print_board
			puts "\n#{@current_player} move!\nEnter the coordinate of the piece you would like to move "\
			"(e.g., a1) or enter 'draw', 'save', or 'quit':\n"
			loop do
				@piece_input = gets.chomp.downcase							
				if valid_coordinate?(@piece_input)
					convert_piece_coordinate(@piece_input)											
					return print_move_input 			
				else
					puts "\nInvalid choice. Choose another coordinate.".red
				end
			end
		end				
	end
		
	def print_move_input	
		puts "\nEnter the coordinate of the square you would like to move the "\
		"selected piece to move to (e.g., a1) or enter 'draw', 'save', or 'quit':\n"
		@move_input = gets.chomp.downcase		
		if valid_coordinate?(@move_input)
			convert_move_coordinate(@move_input)						
			switch_players			
		else			
			puts "\nInvalid choice. Choose another coordinate.".red
		end			
	end

	def switch_players
		@current_player = @current_player == @player_one? @player_two: @player_one
	end

	def convert_piece_coordinate(input)		
		input.split(//)		
		@piece_coor = [@file.index(input[0]), (input[1].to_i)- 1]			
	end
	
	def convert_move_coordinate(input)		
		input.split(//)		
		@move_coor = [@file.index(input[0]), (input[1].to_i)- 1]				
	end

	def valid_coordinate?(input)					
		input.split(//)		
		VALID_CHARS.include?(input[0]) && VALID_CHARS.include?(input[1])				
	end
	
	
end
