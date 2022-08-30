# frozen_string_literal: true

require_relative 'colorize'
require_relative 'pieces'

class Board
  include Pieces

  VALID_CHARS = %w[a b c d e f g h
                   1 2 3 4 5 6 7 8].freeze

  def initialize
    @grid = Array.new(8) { Array.new(8, empty.to_s) }
    @grid[0] = [b_rook.to_s, b_knight.to_s, b_bishop.to_s, b_queen.to_s, b_king.to_s,
                b_bishop.to_s, b_knight.to_s, b_rook.to_s]
    @grid[1] = Array.new(8, b_pawn.to_s)
    @grid[6] = Array.new(8, w_pawn.to_s)
    @grid[7] = [w_rook.to_s, w_knight.to_s, w_bishop.to_s, w_queen.to_s, w_king.to_s,
                w_bishop.to_s, w_knight.to_s, w_rook.to_s]
    @file = %w[a b c d e f g h]
    @rank = 8.downto(1).to_a
  end

  def print_board
    puts "\n"
    @grid.map.with_index do |row, i|
      row.each_index do |n|
        @grid[i][n] = if i.odd? && n.odd? || i.even? && n.even?
                        @grid[i][n].blue_back
                      else
                        @grid[i][n].gray_back
                      end
        case n
        when 0
          print "#{-i + 8} ".yellow
          print @grid[i][n]
        when 7
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
    case player.color
    when :white
      return true if white_pieces.any? { |piece| @current.include?(piece) }
    when :black
      return true if black_pieces.any? { |piece| @current.include?(piece) }
    end
  end
	
	def check_move_square(player)		
		@move_square = @grid[@move_coor[0]][@move_coor[1]]				
		case player.color
    when :white
      return true if white_pieces.none? { |piece| @move_square.include?(piece) }
    when :black
      return true if black_pieces.none? { |piece| @move_square.include?(piece) }
    end				
	end

  def move_piece(_player)
    if @current.include?(w_pawn.to_s)
      w_pawn_moves
    elsif @current.include?(b_pawn.to_s)
      b_pawn_moves
    elsif @current.include?(w_knight.to_s)
      w_knight_moves
    elsif @current.include?(b_knight.to_s)
      b_knight_moves
    elsif @current.include?(w_rook.to_s)
      w_rook_moves
    elsif @current.include?(b_rook.to_s)
      b_rook_moves
    elsif @current.include?(w_bishop.to_s)
      w_bishop_moves
    elsif @current.include?(b_bishop.to_s)
      b_bishop_moves
    elsif @current.include?(w_queen.to_s)
      w_queen_moves
    elsif @current.include?(b_queen.to_s)
      b_queen_moves
    elsif @current.include?(w_king.to_s)
      w_king_moves
    elsif @current.include?(b_king.to_s)
      b_king_moves
    end
    @grid[@piece_coor[0]][@piece_coor[1]] = empty.to_s
  end

  def w_pawn_moves
    if (@piece_coor[0]- 1) == @move_coor[0] 
      @grid[@move_coor[0]][@move_coor[1]] = w_pawn.to_s               
    end
  end

  def b_pawn_moves
    if (@piece_coor[0]	+ 1) == @move_coor[0] 
      @grid[@move_coor[0]][@move_coor[1]] = b_pawn.to_s
    end
  end

  def w_knight_moves		
    if (@piece_coor[0]	- 2) == @move_coor[0] || (@piece_coor[0]	+ 2) == @move_coor[0]
      if (@piece_coor[1] + 1) == @move_coor[1] || (@piece_coor[1] - 1) == @move_coor[1]
        @grid[@move_coor[0]][@move_coor[1]] = w_knight.to_s      
      end   
    elsif (@piece_coor[1]	- 2) == @move_coor[1] || (@piece_coor[1]	+ 2) == @move_coor[1]
      if (@piece_coor[0] + 1) == @move_coor[0] ||	(@piece_coor[0] - 1) == @move_coor[0]			
        @grid[@move_coor[0]][@move_coor[1]] = w_knight.to_s      
      end		    
    end
  end

  def b_knight_moves
    if (@piece_coor[0]	- 2) == @move_coor[0] || (@piece_coor[0]	+ 2) == @move_coor[0]
      if (@piece_coor[1] + 1) == @move_coor[1] || (@piece_coor[1] - 1) == @move_coor[1]
        @grid[@move_coor[0]][@move_coor[1]] = b_knight.to_s      
      end           
    elsif (@piece_coor[1]	- 2) == @move_coor[1] || (@piece_coor[1]	+ 2) == @move_coor[1]
      if (@piece_coor[0] + 1) == @move_coor[0] || (@piece_coor[0] - 1) == @move_coor[0]
        @grid[@move_coor[0]][@move_coor[1]] = b_knight.to_s     
      end   
    end
  end

  def w_rook_moves
    if 1.upto(7){|i| (@piece_coor[0] - i) == @move_coor[0] || (@piece_coor[0] + i) == @move_coor[0]}
      @grid[@move_coor[0]][@move_coor[1]] = w_rook.to_s
    end
    if 1.upto(7){|i| (@piece_coor[1] - i) == @move_coor[1] || (@piece_coor[1] + i) == @move_coor[1]}
      @grid[@move_coor[0]][@move_coor[1]] = w_rook.to_s
    end       
  end

  def b_rook_moves
    if 1.upto(7){|i| (@piece_coor[0] - i) == @move_coor[0] || (@piece_coor[0] + i) == @move_coor[0]}
      @grid[@move_coor[0]][@move_coor[1]] = b_rook.to_s
    end
    if 1.upto(7){|i| (@piece_coor[1] - i) == @move_coor[1] || (@piece_coor[1] + i) == @move_coor[1]}
      @grid[@move_coor[0]][@move_coor[1]] = w_rook.to_s
    end  
  end

  def w_bishop_moves
    #@grid[@move_coor[0]][@move_coor[1]] = w_bishop.to_s
  end

  def b_bishop_moves
    #@grid[@move_coor[0]][@move_coor[1]] =	b_bishop.to_s
  end

  def w_queen_moves
    #@grid[@move_coor[0]][@move_coor[1]] = w_queen.to_s
  end

  def b_queen_moves
    #@grid[@move_coor[0]][@move_coor[1]] =	b_queen.to_s
  end

  def w_king_moves
    #@grid[@move_coor[0]][@move_coor[1]] = w_king.to_s
  end

  def b_king_moves
    #@grid[@move_coor[0]][@move_coor[1]] =	b_king.to_s
  end
end
