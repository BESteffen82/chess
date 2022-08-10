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
      @current = @grid[@piece_coor[0]][@piece_coor[1]]
      @move = @grid[@move_coor[0]][@move_coor[1]] 												
      if @current.include?("#{w_pawn}") || @current.include?("#{b_pawn}")
        pawn_moves						
      elsif @current.include?("#{w_knight}") || @current.include?("#{b_knight}")
        knight_moves
      elsif @current.include?("#{w_rook}") || @current.include?("#{b_rook}")
        rook_moves			
      elsif @current.include?("#{w_bishop}") || @current.include?("#{b_bishop}")
        bishop_moves
      elsif @current.include?("#{w_queen}") || @current.include?("#{b_queen}")
        queen_moves
      elsif @current.include?("#{w_king}") || @current.include?("#{b_king}")
        king_moves
      end		
      @grid[@piece_coor[0]][@piece_coor[1]] = "#{empty}"				
    end

    def pawn_moves
			@grid[@move_coor[0]][@move_coor[1]] = @current.include?("#{w_pawn}") ? "#{w_pawn}" : "#{b_pawn}"				
    end

    def knight_moves
      @grid[@move_coor[0]][@move_coor[1]] = @current.include?("#{w_knight}") ? "#{w_knight}" : "#{b_knight}"		
    end
  
    def rook_moves
      @grid[@move_coor[0]][@move_coor[1]] = @current.include?("#{w_rook}") ? "#{w_rook}" : "#{b_rook}"		
    end

    def bishop_moves
			@grid[@move_coor[0]][@move_coor[1]] = @current.include?("#{w_bishop}") ? "#{w_bishop}" : "#{b_bishop}"		
    end

    def queen_moves
      @grid[@move_coor[0]][@move_coor[1]] = @current.include?("#{w_queen}") ? "#{w_queen}" : "#{b_queen}"		
    end

    def king_moves
      @grid[@move_coor[0]][@move_coor[1]] = @current.include?("#{w_king}") ? "#{w_king}" : "#{b_king}"		
    end	
end

  