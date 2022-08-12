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
    [w_rook, w_knight, w_bishop, w_queen, w_king, w_pawn]
  end

	def black_pieces
		[b_rook, b_knight, b_bishop, b_queen, b_king, b_pawn]
	end
  
end


