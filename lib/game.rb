require_relative 'display'

class Game
	attr_accessor :display

	def initialize		
		@display = Display.new
	end

	def play_game
		@display.game_display
	end	
end
