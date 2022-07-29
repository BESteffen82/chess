class Pawn
	def initialize(color)
		@color = color
	end

	def to_s
		@color == :black ? " \u2659 " : " \u265F "
	end		
end