require_relative 'colorize'

class Board	
	attr_accessor :grid
	
	def initialize		
		@grid = Array.new(8){Array.new(8, "   ")}
	end

	def empty_board
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
end