require_relative 'colorize'
require_relative 'piece_reference'

class Board
		attr_accessor :grid, :pawn, :knight, :bishop, :rook, :queen, :king								
	
	def initialize				
		@grid = Array.new(8){Array.new(8, "#{Empty.new}" )}				
	end

	def print_board
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
		@grid[0][4]	= "#{King.new(:black)}"
		@grid[7][4] = "#{King.new(:white)}"
	end

	def queens
		@grid[0][3]	= "#{Queen.new(:black)}"
		@grid[7][3] = "#{Queen.new(:white)}"
	end

	def rooks
		@grid[0][0]	= "#{Rook.new(:black)}"
		@grid[7][0] = "#{Rook.new(:white)}"
		@grid[0][7]	= "#{Rook.new(:black)}"
		@grid[7][7] = "#{Rook.new(:white)}"
	end

	def bishops
		@grid[0][2]	= "#{Bishop.new(:black)}"
		@grid[7][2] = "#{Bishop.new(:white)}"
		@grid[0][5]	= "#{Bishop.new(:black)}"
		@grid[7][5] = "#{Bishop.new(:white)}"
	end

	def knights
		@grid[0][1]	= "#{Knight.new(:black)}"
		@grid[7][1] = "#{Knight.new(:white)}"
		@grid[0][6]	= "#{Knight.new(:black)}"
		@grid[7][6] = "#{Knight.new(:white)}"
	end

	def pawns
		@grid[1] = Array.new(8, "#{Pawn.new(:black)}")
		@grid[6] = Array.new(8, "#{Pawn.new(:white)}")		
	end	
end

	