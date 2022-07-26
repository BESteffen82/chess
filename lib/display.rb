require_relative 'board'

class Display
	attr_accessor :game_board, :input

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
		@input = gets.chomp
		@game_board.empty_board if input == "1"
	end
end