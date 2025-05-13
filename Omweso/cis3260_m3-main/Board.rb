class Board
  # Instance Variables
  attr_accessor :board

  # Constructors
  def initialize
    # Creates a basic board object
    @board = Array.new(5) { Array.new(9)}
  end

  # Methods
  def capture_piece(square)
    # Removes a piece from the square
    column = (square[0].ord - 65).to_i
    row = square[1].to_i

    row -= 1

    @board[row][column].set_colour(nil)

  end

  def move(initialSquare, destinationSquare)
    # Moves the piece after validation

    if initialSquare == destinationSquare
      return
    end

    if adjacent(initialSquare, destinationSquare) == false
      return
    end

    squareA = Array.new(2)
    squareB = Array.new(2)
    squareA[1] = (initialSquare[0].ord - 65).to_i
    squareA[0] = initialSquare[1].to_i

    squareB[1] = (destinationSquare[0].ord - 65).to_i
    squareB[0] = destinationSquare[1].to_i
    
    squareA[0] -= 1
    squareB[0] -= 1

    @board[squareB[0]][squareB[1]].set_colour(@board[squareA[0]][squareA[1]].get_colour())
    @board[squareA[0]][squareA[1]].set_colour(nil)

  end

  def piece_present(square)
    # Returns the color of piece on the square or empty if none
    column = (square[0].ord - 65).to_i
    row = square[1].to_i
    row -= 1

    if @board[row][column].get_colour().nil?
      return nil

    else
      return @board[row][column].get_colour()

    end
  end

  def end_check
    # Checks if there are pieces of both colors, returns the winner or confirmation

    redFlag = false
    blueFlag = false

    for row in @board
      for column in row
        if column.get_colour().nil?
          next
        end
        if column.get_colour() == "red"
          redFlag = true
        elsif column.get_colour() == "blue"
          blueFlag = true
        end
        if (redFlag && blueFlag) == true
          return false
        end
      end
    end

    if redFlag == true
      return "red"
    elsif blueFlag == true
      return "blue"
    else
      return "tie"

    end
  end

  def to_s
    # Start with column headers
    output = "  a   b   c   d   e   f   g   h   i\n"
  
    @board.each_with_index do |row, row_index|
      # Add row numbers
      output += "#{row_index + 1} "
      
      # Print each tile in the row with lines in between
      row_output = row.map do |tile|
        if tile.get_colour.nil?
          "●"  # Empty tile symbol
        else
          tile.get_colour == "red" ? "\e[31mO\e[0m" : "\e[34m0\e[0m"  # Use "O" for red pieces and "0" for blue pieces
        end
      end.join("---")
      output += row_output + "\n"
  
      # Add connecting lines between rows
      if row_index < @board.length - 1
        if row_index.even?
          output += "  | \\ | / | \\ | / | \\ | / | \\ | / |\n"
        else
          output += "  | / | \\ | / | \\ | / | \\ | / | \\ |\n"
        end
      end
    end
  
    output
  end
  

  def adjacent(initialSquare, destinationSquare)
    # Confirms if two squares are adjacent

    if initialSquare == destinationSquare 
      return false

    end

    squareA = Array.new(2)
    squareB = Array.new(2)

    squareA[1] = (initialSquare[0].ord - 65).to_i
    squareA[0] = initialSquare[1].to_i

    squareB[1] = (destinationSquare[0].ord - 65).to_i
    squareB[0] = destinationSquare[1].to_i

    squareA[0] -= 1
    squareB[0] -= 1

    if ((squareA[0] - squareB[0]) <= 1) && ((squareA[1] - squareB[1]) <= 1)
      return true
    else
      return false
    end
  end

  def detect_capturable
    # Checks for possible captures and returns a boolean
    if @board.nil?
      return false
    end
    for row in (0..@board.length() - 1)
      for column in (0..@board[0].length() - 1)
        # only check non empty tiles
        if @board[row][column].get_colour().nil?
          next
        end
        for i in (-1..1)
          checkRow = row + i
          # break if out of board bounds
          if (checkRow < 0) || (checkRow >= @board.length())
            next
          end
          for j in (-1..1)
            if @board[row][column].get_type()  == "+"
              if (i != 0) && (j != 0)
                next
              end
            end
            # break if comparing tile and original are the same
            if i == 0 && j == 0 
              next
            end
            checkColumn = column + j
            # break if out of board bounds
            if (checkColumn < 0) || (checkColumn >= @board[0].length()) 
              next
            end
            if @board[checkRow][checkColumn].get_colour().nil?
              # break if out of board bounds
              if (row - i < 0) || (row - i >= @board.length())
                next
              end
              # break if out of board bounds
              if (column - j < 0) || (column - j >= @board[0].length())
                next
              end
              if @board[row - i][column - j].get_colour().nil? == false 
                # check if piece availible to capture moving away
                if @board[row - i][column - j].get_colour() != @board[row][column].get_colour()
                  return true
                end
              end 
              # break if out of board bounds
              if (row + (i*2) < 0) || (row + (i*2) >= @board.length()) 
                next
              end
              # break if out of board bounds
              if (column - j < 0) || (column + (j*2) >= @board[0].length()) 
                next
              end
              if @board[row + (i*2)][column + (j*2)].get_colour().nil? == false
                #check if piece available to capture by approaching it
                if @board[row + (i*2)][column + (j*2)].get_colour() != @board[row][column].get_colour() 
                  return true
                end
              end
            end
          end
        end
      end
    end

    return false

  end
  end
