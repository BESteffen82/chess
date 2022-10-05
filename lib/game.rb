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
		loop do
			@game_input = gets.chomp
			return @game_input if @game_input == "1" || @game_input == "2"
			puts "\nInvalid choice. Choose 1 or 2.".red			
		end	 
	end

	def print_piece_input
		if @game_input == "1"		
			@board.print_board
			puts "\n#{@current_player} move!\nEnter the coordinate of the piece you would "\
			"like to move (e.g., a1) or enter 'draw', 'save', or 'quit':\n"
			@piece_input = gets.chomp.downcase																
			if @board.valid_input?(@piece_input) && @board.correct_piece_color?(@current_player) 
				print_move_input	 							 			
			else
				puts "\nInvalid choice. Choose another coordinate.".red
				print_piece_input
			end			
		end				
	end
		
	def print_move_input	
		puts "\nEnter the coordinate of the square you would like to move the "\
		"selected piece to move to (e.g., a1) or enter 'draw', 'save', or 'quit':\n"
		@move_input = gets.chomp.downcase					
		if @board.valid_move?(@move_input) && @board.correct_move_square?(@current_player)			
			@board.move_piece(@current_player)			
			@board.valid_piece_move? ? switch_players : invalid_move
		else
			invalid_move											
		end							
	end

	def switch_players
		@current_player = @current_player == @player_one? @player_two: @player_one
	end
	
	def invalid_move
		puts "\nInvalid move. Choose another coordinate.".red
		print_move_input
	end
end
