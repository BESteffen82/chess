class Queen
	def initialize(color)
		@color = color
	end

	def to_s
		@color == :black ? " \u2655 " : " \u265B "
	end	
end