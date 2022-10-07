0# frozen_string_literal: true

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
    @moves_made = []
    @pawn_promotion = false                          
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

  def correct_piece_color?(player)
    @current = @grid[@piece_coor[0]][@piece_coor[1]]    		
    case player.color
    when :white
      return true if white_pieces.any? { |piece| @current.include?(piece) }
    when :black
      return true if black_pieces.any? { |piece| @current.include?(piece) }
    end
  end
	
	def correct_move_square?(player)		
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
    if valid_piece_move?           
      @grid[@piece_coor[0]][@piece_coor[1]] = empty.to_s
      @moves_made << @move_coor
      if @pawn_promotion == true 
        if @piece_coor[0] == 1 && @current.include?(w_pawn.to_s)
          pawn_promotion
        elsif @piece_coor[0] == 6 && @current.include?(b_pawn.to_s)
          pawn_promotion
        end
      end              
    end    
  end

  def valid_piece_move?    
    return true if w_pawn_moves || b_pawn_moves      
    return true if w_knight_moves || b_knight_moves
    return true if w_rook_moves || b_rook_moves
    return true if w_bishop_moves || b_bishop_moves
    return true if w_queen_moves || b_queen_moves
    return true if w_king_moves || b_king_moves   

    false
  end

  def w_pawn_moves
    if @current.include?(w_pawn.to_s)            
      if valid_pawn_move?
        if @piece_coor[1] == @move_coor[1]
          if @piece_coor[0] == 6
            if @piece_coor[0] - 2 == @move_coor[0] || @piece_coor[0] - 1 == @move_coor[0]
              @grid[@move_coor[0]][@move_coor[1]] = w_pawn.to_s              
            end   
          elsif @piece_coor[0] - 1 == @move_coor[0]
            if @move_coor[0] == 0
              @pawn_promotion = true                             
            else @grid[@move_coor[0]][@move_coor[1]] = w_pawn.to_s
            end            
          end       
        elsif @piece_coor[1] - 1 == @move_coor[1] || @piece_coor[1] + 1 == @move_coor[1]
          if pawn_capture 
            @grid[@move_coor[0]][@move_coor[1]] = w_pawn.to_s
          elsif en_passant
            @grid[2][@move_coor[1]] = w_pawn.to_s
            @grid[3][@last_move[1]] = empty.to_s                                                                                                
          end
        end 
      end      
    end                  
  end

  def b_pawn_moves
    if @current.include?(b_pawn.to_s)      
      if valid_pawn_move?
        if @piece_coor[1] == @move_coor[1]
          if @piece_coor[0] == 1
            if @piece_coor[0] + 2 == @move_coor[0] || @piece_coor[0] + 1 == @move_coor[0]
              @grid[@move_coor[0]][@move_coor[1]] = b_pawn.to_s              
            end   
          elsif @piece_coor[0] + 1 == @move_coor[0]
            if @move_coor[0] == 7
              @pawn_promotion = true                             
            else @grid[@move_coor[0]][@move_coor[1]] = b_pawn.to_s
            end                                                                             
          end
        elsif @piece_coor[1] - 1 == @move_coor[1] || @piece_coor[1] + 1 == @move_coor[1]
          if pawn_capture 
            @grid[@move_coor[0]][@move_coor[1]] = b_pawn.to_s
          elsif en_passant
            @grid[5][@move_coor[1]] = b_pawn.to_s
            @grid[4][@last_move[1]] = empty.to_s                                                                      
          end
        end
      end      
    end       
  end

  def valid_pawn_move?
    pawn_path = []    
    if @piece_coor[1] == @move_coor[1]
      if @piece_coor[0] - 2 == @move_coor[0] || @piece_coor[0] + 2 == @move_coor[0] 
        pawn_path += [@grid[@piece_coor[0] - 1][@move_coor[1]], @move_square]      
      elsif @piece_coor[0] - 1 == @move_coor[0] || @piece_coor[0] + 1 == @move_coor[0] 
        pawn_path << @move_square      
      end
      pawn_path.any? { |path| path.include?(empty) }
    elsif pawn_capture
      return true
    elsif en_passant      
      return true    
    end       
  end
  
  def pawn_capture    
    if @current.include?(w_pawn.to_s)
      if @piece_coor[0] - 1 == @move_coor[0]
        black_pieces.any?{ |piece| @move_square.include?(piece) }
      end
    elsif @current.include?(b_pawn.to_s)
      if @piece_coor[0] + 1 == @move_coor[0]
        white_pieces.any?{ |piece| @move_square.include?(piece) }
      end
    end
  end

  def en_passant    
    @last_move = @moves_made.last                
    if @grid[4][@last_move[1]].include?(w_pawn) && @last_move[1] == @move_coor[1]
      if @piece_coor[0] + 1 == @move_coor[0]
        @grid[4][@piece_coor[1]].include?(b_pawn)
        @move_square.include?(empty)
      end
    elsif @grid[3][@last_move[1]].include?(b_pawn) && @last_move[1] == @move_coor[1]
      if @piece_coor[0] - 1 == @move_coor[0]        
        @grid[3][@piece_coor[1]].include?(w_pawn)
        @move_square.include?(empty)                        
      end      
    end
    return true if @last_move[1] == @move_coor[1]               
  end

  def pawn_promotion        
    puts "\nPawn Promotion! Select a number to upgrade your pawn to a new piece.".green
    puts "[1] Queen\n[2] Knight\n[3] Rook\n[4] Bishop".green
    loop do
      @promo_choice = gets.chomp.to_i
      case @promo_choice
      when 1        
        return @grid[@move_coor[0]][@move_coor[1]] = w_queen.to_s if @current.include?(w_pawn.to_s)
        return @grid[@move_coor[0]][@move_coor[1]] = b_queen.to_s                
      when 2        
        return @grid[@move_coor[0]][@move_coor[1]] = w_knight.to_s if @current.include?(w_pawn.to_s)
        return @grid[@move_coor[0]][@move_coor[1]] = b_knight.to_s               
      when 3        
        return @grid[@move_coor[0]][@move_coor[1]] = w_rook.to_s if @current.include?(w_pawn.to_s)
        return @grid[@move_coor[0]][@move_coor[1]] = b_rook.to_s               
      when 4        
        return @grid[@move_coor[0]][@move_coor[1]] = w_bishop.to_s if @current.include?(w_pawn.to_s)
        return @grid[@move_coor[0]][@move_coor[1]] = b_bishop.to_s               
      else return puts "\nInvalid choice. Enter a number 1 to 4.".red
      end
    end              
  end

  def w_knight_moves
    if @current.include?(w_knight.to_s)
      if valid_knight_move?		
        if @piece_coor[0]	- 2 == @move_coor[0] || @piece_coor[0]	+ 2 == @move_coor[0]
          if @piece_coor[1] + 1 == @move_coor[1] || @piece_coor[1] - 1 == @move_coor[1]
            @grid[@move_coor[0]][@move_coor[1]] = w_knight.to_s                            
          end   
        elsif @piece_coor[1]	- 2 == @move_coor[1] || @piece_coor[1]	+ 2 == @move_coor[1]
          if @piece_coor[0] + 1 == @move_coor[0] ||	@piece_coor[0] - 1 == @move_coor[0]			
            @grid[@move_coor[0]][@move_coor[1]] = w_knight.to_s                            
          end
        end
      end      		    
    end    
  end

  def b_knight_moves
    if @current.include?(b_knight.to_s)
      if valid_knight_move?
        if @piece_coor[0]	- 2 == @move_coor[0] || @piece_coor[0]	+ 2 == @move_coor[0]
          if @piece_coor[1] + 1 == @move_coor[1] || @piece_coor[1] - 1 == @move_coor[1]
            @grid[@move_coor[0]][@move_coor[1]] = b_knight.to_s                            
          end           
        elsif @piece_coor[1]	- 2 == @move_coor[1] || @piece_coor[1]	+ 2 == @move_coor[1]
          if @piece_coor[0] + 1 == @move_coor[0] || @piece_coor[0] - 1 == @move_coor[0]
            @grid[@move_coor[0]][@move_coor[1]] = b_knight.to_s                           
          end
        end
      end      
    end    
  end

  def valid_knight_move?
    knight_path = []
    if @piece_coor[0] + 2 == @move_coor[0]
      knight_path += [@grid[@move_coor[0]][@piece_coor[1]], @grid[@piece_coor[0] + 1][@move_coor[1]]]       
    elsif @piece_coor[0] - 2 == @move_coor[0]     
      knight_path += [@grid[@move_coor[0]][@piece_coor[1]], @grid[@piece_coor[0] - 1][@move_coor[1]]]                                   
    elsif @piece_coor[1] - 2 == @move_coor[1]
      knight_path += [@grid[@piece_coor[0]][@move_coor[1]], @grid[@move_coor[0]][@piece_coor[1] - 1]]       
    elsif @piece_coor[1] + 2 == @move_coor[1]
      knight_path += [@grid[@piece_coor[0]][@move_coor[1]], @grid[@move_coor[0]][@piece_coor[1] + 1]]           
    end
    knight_path.any? { |path| path.include?(empty) }
  end

  def w_rook_moves    
    if @current.include?(w_rook.to_s)      
      for i in 1..7
        if valid_rook_move?                  
          if @piece_coor[1] == @move_coor[1] 
            if @piece_coor[0] - i == @move_coor[0] || @piece_coor[0] + i == @move_coor[0]   
              @grid[@move_coor[0]][@move_coor[1]] = w_rook.to_s
              return true
            end          
          elsif @piece_coor[0] == @move_coor[0] 
            if @piece_coor[1] - i == @move_coor[1] || @piece_coor[1] + i == @move_coor[1]
              @grid[@move_coor[0]][@move_coor[1]] = w_rook.to_s
              return true        
            end
          end
        end              
      end
    end
    false        
  end

  def b_rook_moves
    if @current.include?(b_rook.to_s)
      for i in 1..7
        if valid_rook_move?
          if @piece_coor[1] == @move_coor[1]
            if @piece_coor[0] - i == @move_coor[0] || @piece_coor[0] + i == @move_coor[0]   
            @grid[@move_coor[0]][@move_coor[1]] = b_rook.to_s
            return true
            end          
          elsif @piece_coor[0] == @move_coor[0] 
            if @piece_coor[1] - i == @move_coor[1] || @piece_coor[1] + i == @move_coor[1]
              @grid[@move_coor[0]][@move_coor[1]] = b_rook.to_s
              return true        
            end
          end
        end        
      end
    end
    false    
  end

  def valid_rook_move?
    rook_path = []
    if @piece_coor[0] > @move_coor[0]          
      (@piece_coor[0] - 1).downto(@move_coor[0] + 1) { |i| rook_path << @grid[i][@piece_coor[1]] }                             
    elsif @piece_coor[0] < @move_coor[0] && @piece_coor[1] == @move_coor[1]
      (@piece_coor[0] + 1).upto(@move_coor[0] - 1) { |i| rook_path << @grid[i][@piece_coor[1]] }                
    elsif @piece_coor[1] > @move_coor[1] && @piece_coor[0] == @move_coor[0]         
      (@piece_coor[1] - 1).downto(@move_coor[1] + 1) { |i| rook_path << @grid[@piece_coor[0]][i] }        
    elsif @piece_coor[1] < @move_coor[1] && @piece_coor[0] == @move_coor[0]
      (@piece_coor[1] + 1).upto(@move_coor[1] - 1) { |i| rook_path << @grid[@piece_coor[0]][i] }           
    end
    rook_path.all? { |path| path.include?(empty) }                                       
  end

  def w_bishop_moves            
    if @current.include?(w_bishop.to_s)            
      for i in 1..7
        if valid_bishop_move?
          if @piece_coor[1] - i == @move_coor[1] || @piece_coor[1] + i == @move_coor[1]
            if @piece_coor[0] - i == @move_coor[0] || @piece_coor[0] + i == @move_coor[0]  
              @grid[@move_coor[0]][@move_coor[1]] = w_bishop.to_s
              return true
            end                                                      
          end
        end        
      end      
    end
    false    
  end

  def b_bishop_moves
    if @current.include?(b_bishop.to_s)            
      for i in 1..7
        if valid_bishop_move?
          if @piece_coor[1] - i == @move_coor[1] || @piece_coor[1] + i == @move_coor[1]
            if @piece_coor[0] - i == @move_coor[0] || @piece_coor[0] + i == @move_coor[0]  
              @grid[@move_coor[0]][@move_coor[1]] = b_bishop.to_s
              return true
            end                  
          end
        end        
      end      
    end
    false        
  end

  def valid_bishop_move?
    bishop_path = []
    1.upto(7) do |i|
      if (@piece_coor[0] - i) > @move_coor[0] && (@piece_coor[1] - i) > @move_coor[1]
        bishop_path << @grid[@piece_coor[0] - i][@piece_coor[1] - i]      
      elsif (@piece_coor[0] + i) < @move_coor[0] && (@piece_coor[1] + i) < @move_coor[1]
        bishop_path << @grid[@piece_coor[0] + i][@piece_coor[1] + i]       
      elsif (@piece_coor[0] - i) > @move_coor[0] && (@piece_coor[1] + i) < @move_coor[1]        
        bishop_path << @grid[@piece_coor[0] - i][@piece_coor[1] + i]        
      elsif (@piece_coor[0] + i) < @move_coor[0] && (@piece_coor[1] - i) > @move_coor[1]
        bishop_path << @grid[@piece_coor[0] + i][@piece_coor[1] - i]
      end           
    end    
    bishop_path.all? { |path| path.include?(empty) }        
  end

  def w_queen_moves
    if @current.include?(w_queen.to_s)
      for i in 1..7
        if valid_bishop_move? && valid_rook_move?
          if @piece_coor[1] == @move_coor[1] || @piece_coor[1] - i == @move_coor[1] || @piece_coor[1] + i == @move_coor[1]
            if @piece_coor[0] - i == @move_coor[0] || @piece_coor[0] + i == @move_coor[0] || @piece_coor[0] == @move_coor[0]
              @grid[@move_coor[0]][@move_coor[1]] = w_queen.to_s
              return true
            end        
          end
        end            
      end
    end
    false
  end

  def b_queen_moves
    if @current.include?(b_queen.to_s)
      for i in 1..7
        if valid_bishop_move? && valid_rook_move?
          if @piece_coor[1] == @move_coor[1] || @piece_coor[1] - i == @move_coor[1] || @piece_coor[1] + i == @move_coor[1]
            if @piece_coor[0] - i == @move_coor[0] || @piece_coor[0] + i == @move_coor[0] || @piece_coor[0] == @move_coor[0]
              @grid[@move_coor[0]][@move_coor[1]] = b_queen.to_s
              return true
            end
          end
        end            
      end
    end
    false
  end

  def w_king_moves
    if @current.include?(w_king.to_s)
      if @piece_coor[0] - 1 == @move_coor[0] || @piece_coor[0] + 1 == @move_coor[0] || @piece_coor[0] == @move_coor[0]
        if @piece_coor[1] + 1 ==@move_coor[1] || @piece_coor[1] - 1 == @move_coor[1] || @piece_coor[1] == @move_coor[1]
          @grid[@move_coor[0]][@move_coor[1]] = w_king.to_s          
        end      
      end
    end    
  end
    

  def b_king_moves
    if @current.include?(b_king.to_s)
      if @piece_coor[0] - 1 == @move_coor[0] || @piece_coor[0] + 1 == @move_coor[0] || @piece_coor[0] == @move_coor[0]
        if @piece_coor[1] + 1 ==@move_coor[1] || @piece_coor[1] - 1 == @move_coor[1] || @piece_coor[1] == @move_coor[1]
          @grid[@move_coor[0]][@move_coor[1]] = b_king.to_s          
        end      
      end
    end    
  end  
end
