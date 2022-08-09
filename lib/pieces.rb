module Pieces
	def empty 
		"   "
	end

	def w_king
		" \u265A "
	end

	def b_king
		" \u2654 "
	end

	def w_queen
		" \u265B "
	end

	def b_queen
		" \u2655 "
	end

	def w_rook
		" \u265C "
	end

	def b_rook
		" \u2656 "
	end

	def w_bishop
		" \u265D "
	end

	def b_bishop
		" \u2657 "
	end

	def w_knight
		" \u265E "
	end

	def b_knight
		" \u2658 "
	end

	def w_pawn
		" \u265F "
	end

	def b_pawn
		" \u2659 "
	end

	def white_pieces
    [" \u265A ", " \u265B ", " \u265C ", " \u265D ", " \u265E ", " \u265F "]
  end

	def black_pieces
		[" \u2654 ", " \u2655 ", " \u2656 ", " \u2657 ", " \u2658 ", " \u2659 "]
	end
  
end


