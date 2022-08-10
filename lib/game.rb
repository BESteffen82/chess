require_relative 'board'
require_relative 'player'

class Game	
	def initialize		
		@board = Board.new		
		@player_one = Player.new(:white)
		@player_two = Player.new(:black)
		@current_player = @player_one
	end

	def play_game				
		game_setup
		loop do
			print_piece_input		
			@board.move_piece		
			switch_players
		end												
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
	end

	def print_piece_input
		if @game_input == "1"		
			@board.print_board
			puts "\n#{@current_player} move!\nEnter the coordinate of the piece you would "\
			"like to move (e.g., a1) or enter 'draw', 'save', or 'quit':\n"
			@piece_input = gets.chomp.downcase							
			if @board.valid_input?(@piece_input)
				@board.convert_piece_coordinate(@piece_input)											
				return print_move_input 			
			else
				puts "\nInvalid choice. Choose another coordinate.".red
			end			
		end				
	end
		
	def print_move_input	
		puts "\nEnter the coordinate of the square you would like to move the "\
		"selected piece to move to (e.g., a1) or enter 'draw', 'save', or 'quit':\n"
		@move_input = gets.chomp.downcase		
		if @board.valid_move?(@move_input)
			@board.convert_move_coordinate(@move_input)								
		else			
			puts "\nInvalid choice. Choose another coordinate.".red
		end			
	end

	def switch_players
		@current_player = @current_player == @player_one? @player_two: @player_one
	end	
end
