require_relative 'colorize'
require_relative 'pieces'

class Board 
		include Pieces		
		
		VALID_CHARS = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',
			'1', '2', '3', '4', '5', '6', '7', '8']	
	
	def initialize				
		@grid = Array.new(8){Array.new(8, "#{empty}" )}
		@grid[0] = ["#{b_rook}","#{b_knight}","#{b_bishop}","#{b_queen}","#{b_king}",
			"#{b_bishop}","#{b_knight}","#{b_rook}"]    
    @grid[1] = Array.new(8, "#{b_pawn}")
    @grid[6] = Array.new(8, "#{w_pawn}")
		@grid[7] = ["#{w_rook}","#{w_knight}","#{w_bishop}","#{w_queen}","#{w_king}",
			"#{w_bishop}","#{w_knight}","#{w_rook}"]
		@file = %w[a b c d e f g h]
		@rank = 8.downto(1).to_a												
	end

	def print_board
		puts "\n"						
		@grid.map.with_index do |row, i|
			row.each_index do |n|																					
				if i.odd? && n.odd? || i.even? && n.even?
				@grid[i][n] = @grid[i][n].blue_back																		  										
				else
				@grid[i][n] = @grid[i][n].gray_back																				
				end												
				if n == 0 																																		
					print "#{-i + 8} ".yellow
					print @grid[i][n]																											  					
				elsif n == 7
					print @grid[i][n] 
					print "\n"					
				else print @grid[i][n]	 
				end																																									
			end										
		end
		print "   a  b  c  d  e  f  g  h\n".yellow											
	end
	
	def convert_piece_coordinate(input)		
		input.split(//)		
		@piece_coor = [@rank.index(input[1].to_i), @file.index(input[0])]					
	end
	
	def convert_move_coordinate(input)		
		input.split(//)		
		@move_coor = [@rank.index(input[1].to_i), @file.index(input[0])]					
	end	


	def valid_input?(input)					
		input.split(//)		
		VALID_CHARS.include?(input[0]) && VALID_CHARS.include?(input[1])
	end

	def valid_move?(input)					
		input.split(//)		
		VALID_CHARS.include?(input[0]) && VALID_CHARS.include?(input[1])
	end

	def move_piece
		piece = @grid[@piece_coor[0]][@piece_coor[1]]				
		if piece.include?("#{w_pawn}") || piece.include?("#{b_pawn}")
		  pawn_moves				
		elsif piece.include?("#{w_knight}") || piece.include?("#{b_knight}")
		  knight_moves
		elsif piece.include?("#{w_rook}") || piece.include?("#{b_rook}")
		  rook_moves			
		elsif piece.include?("#{w_bishop}") || piece.include?("#{b_bishop}")
		  bishop_moves
		elsif piece.include?("#{w_queen}") || piece.include?("#{b_queen}")
		  queen_moves
		elsif piece.include?("#{w_king}") || piece.include?("#{b_king}")
		  king_moves
		end				
	end

	def pawn_moves
		if @grid[@piece_coor[0]][@piece_coor[1]].include?("#{w_pawn}")
			@grid[@move_coor[0]][@move_coor[1]] = "#{w_pawn}"			
		else 
			@grid[@move_coor[0]][@move_coor[1]] = "#{b_pawn}"			
		end
		@grid[@piece_coor[0]][@piece_coor[1]] = "#{empty}"		
	end

	def knight_moves
		if @grid[@piece_coor[0]][@piece_coor[1]].include?("#{w_knight}")
			@grid[@move_coor[0]][@move_coor[1]] = "#{w_knight}"			
		else 
			@grid[@move_coor[0]][@move_coor[1]] = "#{b_knight}"			
		end
		@grid[@piece_coor[0]][@piece_coor[1]] = "#{empty}"
	end
	
	def rook_moves
		if @grid[@piece_coor[0]][@piece_coor[1]].include?("#{w_rook}")
			@grid[@move_coor[0]][@move_coor[1]] = "#{w_rook}"			
		else 
			@grid[@move_coor[0]][@move_coor[1]] = "#{b_rook}"			
		end
		@grid[@piece_coor[0]][@piece_coor[1]] = "#{empty}"
	end

	def bishop_moves
		if @grid[@piece_coor[0]][@piece_coor[1]].include?("#{w_bishop}")
			@grid[@move_coor[0]][@move_coor[1]] = "#{w_bishop}"			
		else 
			@grid[@move_coor[0]][@move_coor[1]] = "#{b_bishop}"			
		end
		@grid[@piece_coor[0]][@piece_coor[1]] = "#{empty}"
	end

	def queen_moves
		if @grid[@piece_coor[0]][@piece_coor[1]].include?("#{w_queen}")
			@grid[@move_coor[0]][@move_coor[1]] = "#{w_queen}"			
		else 
			@grid[@move_coor[0]][@move_coor[1]] = "#{b_queen}"			
		end
		@grid[@piece_coor[0]][@piece_coor[1]] = "#{empty}"
	end

	def king_moves
		if @grid[@piece_coor[0]][@piece_coor[1]].include?("#{w_king}")
			@grid[@move_coor[0]][@move_coor[1]] = "#{w_king}"			
		else 
			@grid[@move_coor[0]][@move_coor[1]] = "#{b_king}"			
		end
		@grid[@piece_coor[0]][@piece_coor[1]] = "#{empty}"
	end	
end

	