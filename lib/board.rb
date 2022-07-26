require_relative 'colorize'
require_relative 'piece_reference'

class Board	
	attr_accessor :grid
	
	def initialize
		@empty = Empty.new
		@king = King.new
		@queen = Queen.new
		@rook = Rook.new
		@bishop = Bishop.new
		@knight = Knight.new
		@pawn = Pawn.new				
		@grid = Array.new(8){Array.new(8, "#{@empty}" )}
	end

	def empty_board
		puts "\n"						
		@grid.map.with_index do |row, i|
			row.each_index do |n|
				place_initial_pieces				
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
	
	def place_initial_pieces
		kings && queens && rooks && bishops && knights && pawns
	end
	
	def kings	
		@grid[0][4]	= "#{@king.black}"
		@grid[7][4] = "#{@king.white}"
	end

	def queens
		@grid[0][3]	= "#{@queen.black}"
		@grid[7][3] = "#{@queen.white}"
	end

	def rooks
		@grid[0][0]	= "#{@rook.black}"
		@grid[7][0] = "#{@rook.white}"
		@grid[0][7]	= "#{@rook.black}"
		@grid[7][7] = "#{@rook.white}"
	end

	def bishops
		@grid[0][2]	= "#{@bishop.black}"
		@grid[7][2] = "#{@bishop.white}"
		@grid[0][5]	= "#{@bishop.black}"
		@grid[7][5] = "#{@bishop.white}"
	end

	def knights
		@grid[0][1]	= "#{@knight.black}"
		@grid[7][1] = "#{@knight.white}"
		@grid[0][6]	= "#{@knight.black}"
		@grid[7][6] = "#{@knight.white}"
	end

	def pawns
		@grid[1] = Array.new(8, "#{@pawn.black}")
		@grid[6] = Array.new(8, "#{@pawn.white}")		
	end
end