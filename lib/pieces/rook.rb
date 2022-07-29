class Rook
	def initialize(color)
		@color = color
	end

	def to_s
		@color == :black ? " \u2656 " : " \u265C "
	end	
end