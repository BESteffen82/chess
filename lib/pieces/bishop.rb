class Bishop
	def initialize(color)
		@color = color
	end

	def to_s
		@color == :black ? " \u2657 " : " \u265D "
	end	
end