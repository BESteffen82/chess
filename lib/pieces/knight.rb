class Knight
	def initialize(color)
		@color = color
	end

	def to_s
		@color == :black ? " \u2658 " : " \u265E "
	end	
end