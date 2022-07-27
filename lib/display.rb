require_relative 'board'


class Display
	VALID_CHARS = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',
								'1', '2', '3', '4', '5', '6', '7', '8']

	attr_accessor :game_board, :game_input, :white_input

	def initialize
		@game_board = Board.new
	end
	
	def game_display
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
		print_white_input if @game_input == "1"
	end

	def print_white_input		
		@game_board.empty_board
		puts "\nWhite move!\nEnter the coordinate of the piece you would like to move "\
		"(e.g., a1) or enter 'draw', 'save', or 'quit':\n"
		loop do
			@white_input = gets.chomp.downcase				
			return print_white_move if valid_input_coordinate?			

			puts "\nInvalid choice. Choose another coordinate.".red
		end		
	end
		
	def print_white_move	
		puts "\nEnter the coordinate of the square you would like to move the "\
		"selected piece to move to (e.g., a1) or enter 'draw', 'save', or 'quit':\n"
		@white_move = gets.chomp.downcase		
	end

	def valid_input_coordinate?					
		@white_input.split(//)		
		VALID_CHARS.include?(@white_input[0]) && VALID_CHARS.include?(@white_input[1])				
	end

	def valid_move_coordinate?					
		@white_move.split(//)		
		VALID_CHARS.include?(@white_move[0]) && VALID_CHARS.include?(@white_move[1])				
	end
end