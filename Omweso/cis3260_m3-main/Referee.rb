class Referee
  # Instance Variables
  attr_accessor :board

  # Constructor
  def initialize(board)
    @board = board
  end

  # Methods
  # NOTE: need player to determine initial squares' colour
  def validate_move(initialSquare, destinationSquare, player)
    if @board.adjacent(initialSquare, destinationSquare) &&
       @board.piece_present(destinationSquare).nil? &&
       @board.piece_present(initialSquare) == player.get_colour

      capture_type = capture_type(initialSquare, destinationSquare, player)

      if !@board.detect_capturable
        return "nonCapture"
      else
        # NOTE: since it's forced capture, if we prove that it's not nonCapture, then it must be Capture
        return "capture"
      end
    else
      return nil # This is invalid for now
    end
  end

  def capture_type(initialSquare, destinationSquare, player)
    # Get coordinates for both squares
    init_col = initialSquare[0].ord - 65
    init_row = initialSquare[1].to_i - 1
    dest_col = destinationSquare[0].ord - 65
    dest_row = destinationSquare[1].to_i - 1

    # Calculate direction of movement
    col_dir = dest_col - init_col
    row_dir = dest_row - init_row

    # Check for advancing capture in the direction that you moved
    next_col = dest_col + col_dir
    next_row = dest_row + row_dir

    advancing = false
    retreating = false

    # Check advancing capture if within bounds
    if next_row.between?(0, 4) && next_col.between?(0, 8)
      piece_colour = @board.board[next_row][next_col].get_colour
      init_type = @board.board[next_row][next_col].get_type

      if !piece_colour.nil? && piece_colour != player.get_colour
        # Check if move is valid based on type
        advancing = true if init_type == "+" && (col_dir == 0 || row_dir == 0)
        advancing = true if init_type == "*"
      end
    end
    
    # Check for retreating capture in opposite direction
    prev_col = init_col - col_dir
    prev_row = init_row - row_dir

    if prev_row.between?(0, 4) && prev_col.between?(0, 8)
      piece_colour = @board.piece_present("#{(prev_col + 65).chr}#{prev_row + 1}")

      if !piece_colour.nil? && piece_colour != player.get_colour
        # Check if this move is valid based on intersection type
        retreating = true if init_type == "+" && (col_dir == 0 || row_dir == 0)
        retreating = true if init_type == "*"
      end
    end

    return nil unless advancing || retreating
    return "both" if advancing && retreating
    return "advancing" if advancing
    return "retreating" if retreating
  end

  # NOTE: added players input
  def end_check(players)
    # Determines if the game should end, returns winner or false
    result = @board.end_check
    players.each do |player|
      # If the result matches a player's colour, return the player's ID as the winner
      return player.get_id if player.get_colour == result
    end

    # If result is "tie" or false
    result
  end

  def check_repeated_capture(destinationSquare)
    # Checks for possible repeated captures, returns a boolean
    col = destinationSquare[0].ord - 65
    row = destinationSquare[1].to_i - 1
    current_colour = @board.piece_present(destinationSquare)

    # Check all adjacent squares
    (-1..1).each do |row_offset|
      next_row = row + row_offset
      next unless next_row.between?(0, 4)

      (-1..1).each do |col_offset|
        next if col_offset == 0 && row_offset == 0
        next_col = col + col_offset
        next unless next_col.between?(0, 8)

        next_square = "#{(next_col + 65).chr}#{next_row + 1}"
        current_square = "#{(col + 65).chr}#{row + 1}"

        # Skip if squares aren't beside each other
        next unless @board.adjacent(current_square, next_square)

        # Check if there's a possible capture
        if @board.piece_present(next_square).nil?
          # Advancing capture
          advance_col = next_col + col_offset
          advance_row = next_row + row_offset

          if advance_row.between?(0, 4) && advance_col.between?(0, 8)
            advance_square = "#{(advance_col + 65).chr}#{advance_row + 1}"
            piece_colour = @board.board[advance_row][advance_col].get_colour

            return true if !piece_colour.nil? && piece_colour != current_colour
          end

          # Retreating capture
          retreat_col = col - col_offset
          retreat_row = row - row_offset

          if retreat_row.between?(0, 4) && retreat_col.between?(0, 8)
            retreat_square = "#{(retreat_col + 65).chr}#{retreat_row + 1}"
            piece_colour = @board.piece_present(retreat_square)

            return true if !piece_colour.nil? && piece_colour != current_colour
          end
        end
      end
    end
    false
  end

  def capture_pieces(initialSquare, destinationSquare, captureType)
    init_col = initialSquare[0].ord - 65
    init_row = initialSquare[1].to_i - 1
    dest_col = destinationSquare[0].ord - 65
    dest_row = destinationSquare[1].to_i - 1

    col_dir = dest_col - init_col
    row_dir = dest_row - init_row

    case captureType
    when "advancing"
      current_col = dest_col + col_dir
      current_row = dest_row + row_dir

      while current_row.between?(0, 4) && current_col.between?(0, 8)
        current_square = "#{(current_col + 65).chr}#{current_row + 1}"
        piece_colour = @board.piece_present(current_square)

        break if piece_colour.nil? || piece_colour == @board.piece_present(initialSquare)

        @board.capture_piece(current_square)
        current_col += col_dir
        current_row += row_dir
      end
    when "retreating"
      current_col = init_col - col_dir
      current_row = init_row - row_dir

      while current_row.between?(0, 4) && current_col.between?(0, 8)
        current_square = "#{(current_col + 65).chr}#{current_row + 1}"
        piece_colour = @board.piece_present(current_square)

        break if piece_colour.nil? || piece_colour == @board.piece_present(initialSquare)

        @board.capture_piece(current_square)
        current_col -= col_dir
        current_row -= row_dir
      end
    end
  end
end
