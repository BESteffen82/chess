require_relative 'colorize'
require_relative 'pieces'

class Board 
	include Pieces		
	
	VALID_CHARS = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',
									'1', '2', '3', '4', '5', '6', '7', '8']	

	def initialize				
		@grid = Array.new(8) { Array.new(8, "#{empty}") }
		@grid[0] = ["#{b_rook}", "#{b_knight}", "#{b_bishop}", "#{b_queen}", "#{b_king}",
									"#{b_bishop}", "#{b_knight}", "#{b_rook}"]    
		@grid[1] = Array.new(8, "#{b_pawn}")
		@grid[6] = Array.new(8, "#{w_pawn}")
		@grid[7] = ["#{w_rook}", "#{w_knight}", "#{w_bishop}", "#{w_queen}", "#{w_king}",
									"#{w_bishop}", "#{w_knight}", "#{w_rook}"]
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
				else
		print @grid[i][n]	 
				end																																									
			end										
		end
		print "   a  b  c  d  e  f  g  h\n".yellow											
	end

	def valid_input?(input)					
		input.split(//)
		@piece_coor = [@rank.index(input[1].to_i), @file.index(input[0])]		
		VALID_CHARS.include?(input[0]) && VALID_CHARS.include?(input[1]) && input.size < 3		 				
	end

	def valid_move?(input)					
		input.split(//)
		@move_coor = [@rank.index(input[1].to_i), @file.index(input[0])]		
		VALID_CHARS.include?(input[0]) && VALID_CHARS.include?(input[1]) && input.size < 3			 
	end

	def check_piece_color(player)		
		@current = @grid[@piece_coor[0]][@piece_coor[1]]							
		if player.color == :white
			return true if white_pieces.any?{|piece| @current.include?(piece)}								
		elsif player.color == :black
			return true if black_pieces.any?{|piece| @current.include?(piece)}
		end			   												
	end	

	def move_piece(player)																	
		if @current.include?("#{w_pawn}")			 
			w_pawn_moves
		elsif @current.include?("#{b_pawn}")
			b_pawn_moves						
		elsif @current.include?("#{w_knight}")
			w_knight_moves
		elsif @current.include?("#{b_knight}")
			b_knight_moves	
		elsif @current.include?("#{w_rook}")
			w_rook_moves
		elsif @current.include?("#{b_rook}")
			b_rook_moves				
		elsif @current.include?("#{w_bishop}")
			w_bishop_moves
		elsif @current.include?("#{b_bishop}")
			b_bishop_moves	
		elsif @current.include?("#{w_queen}")
			w_queen_moves
		elsif @current.include?("#{b_queen}")
			b_queen_moves	
		elsif @current.include?("#{w_king}")
			w_king_moves
		elsif @current.include?("#{b_king}")
			b_king_moves	
		end		
		@grid[@piece_coor[0]][@piece_coor[1]] = "#{empty}"					
	end

	def w_pawn_moves				 			 
		@grid[@move_coor[0]][@move_coor[1]] = "#{w_pawn}"					
	end

	def b_pawn_moves		
		@grid[@move_coor[0]][@move_coor[1]] =	"#{b_pawn}"									
	end

	def w_knight_moves		
		if (@piece_coor[0]	- 2) == @move_coor[0]
			if (@piece_coor[1] + 1) == @move_coor[1]  			 
				@grid[@move_coor[0]][@move_coor[1]] = "#{w_knight}"
			elsif (@piece_coor[1] - 1) == @move_coor[1]
				@grid[@move_coor[0]][@move_coor[1]] = "#{w_knight}"	
			end
		end
		if (@piece_coor[0]	+ 2) == @move_coor[0]
			if (@piece_coor[1] + 1) == @move_coor[1]  			 
				@grid[@move_coor[0]][@move_coor[1]] = "#{w_knight}"
			elsif (@piece_coor[1] - 1) == @move_coor[1]
				@grid[@move_coor[0]][@move_coor[1]] = "#{w_knight}"	
			end
		end
		if (@piece_coor[1]	- 2) == @move_coor[1]
			if (@piece_coor[0] + 1) == @move_coor[0]  			 
				@grid[@move_coor[0]][@move_coor[1]] = "#{w_knight}"
			elsif (@piece_coor[0] - 1) == @move_coor[0]
				@grid[@move_coor[0]][@move_coor[1]] = "#{w_knight}"	
			end
		end
		if (@piece_coor[1]	+ 2) == @move_coor[1]
			if (@piece_coor[0] + 1) == @move_coor[0]  			 
				@grid[@move_coor[0]][@move_coor[1]] = "#{w_knight}"
			elsif (@piece_coor[0] - 1) == @move_coor[0]
				@grid[@move_coor[0]][@move_coor[1]] = "#{w_knight}"	
			end
		end 				 				 				 				
	end

	def b_knight_moves		
		if (@piece_coor[0]	- 2) == @move_coor[0]
			if (@piece_coor[1] + 1) == @move_coor[1]  			 
				@grid[@move_coor[0]][@move_coor[1]] = "#{b_knight}"
			elsif (@piece_coor[1] - 1) == @move_coor[1]
				@grid[@move_coor[0]][@move_coor[1]] = "#{b_knight}"	
			end
		end
		if (@piece_coor[0]	+ 2) == @move_coor[0]
			if (@piece_coor[1] + 1) == @move_coor[1]  			 
				@grid[@move_coor[0]][@move_coor[1]] = "#{b_knight}"
			elsif (@piece_coor[1] - 1) == @move_coor[1]
				@grid[@move_coor[0]][@move_coor[1]] = "#{b_knight}"	
			end
		end
		if (@piece_coor[1]	- 2) == @move_coor[1]
			if (@piece_coor[0] + 1) == @move_coor[0]  			 
				@grid[@move_coor[0]][@move_coor[1]] = "#{b_knight}"
			elsif (@piece_coor[0] - 1) == @move_coor[0]
				@grid[@move_coor[0]][@move_coor[1]] = "#{b_knight}"	
			end
		end
		if (@piece_coor[1]	+ 2) == @move_coor[1]
			if (@piece_coor[0] + 1) == @move_coor[0]  			 
				@grid[@move_coor[0]][@move_coor[1]] = "#{b_knight}"
			elsif (@piece_coor[0] - 1) == @move_coor[0]
				@grid[@move_coor[0]][@move_coor[1]] = "#{b_knight}"	
			end
		end 				 				 				 				 				 													
	end

	def w_rook_moves			 
		@grid[@move_coor[0]][@move_coor[1]] = "#{w_rook}"			
	end

	def b_rook_moves		
		@grid[@move_coor[0]][@move_coor[1]] =	"#{b_rook}"									
	end

	def w_bishop_moves			 
		@grid[@move_coor[0]][@move_coor[1]] = "#{w_bishop}"			
	end

	def b_bishop_moves		
		@grid[@move_coor[0]][@move_coor[1]] =	"#{b_bishop}"									
	end

	def w_queen_moves			 
		@grid[@move_coor[0]][@move_coor[1]] = "#{w_queen}"			
	end

	def b_queen_moves		
		@grid[@move_coor[0]][@move_coor[1]] =	"#{b_queen}"									
	end

	def w_king_moves			 
		@grid[@move_coor[0]][@move_coor[1]] = "#{w_king}"			
	end

	def b_king_moves		
		@grid[@move_coor[0]][@move_coor[1]] =	"#{b_king}"									
	end
end

  