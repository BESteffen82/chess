class King
	def initialize(color)
		@color = color
	end

	def to_s
		@color == :black ? " \u2654 " : " \u265A "		
	end	
end