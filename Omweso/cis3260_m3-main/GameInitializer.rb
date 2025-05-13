class GameInitializer
  # Constructors
  def initialize
    # Creates a basic game initializer object
  end

  # Methods
  def initialise_board
    # Initializes the board and returns the state
    board = Array.new(5) { Array.new(9) }
    height = 5
    width = 9
    type = ""
  
    for i in (0..height-1)
      for j in (0..width-1)
        if (i % 2 == 0) && (j % 2 == 0)
          type = "*"
        elsif (i % 2 == 0) && (j % 2 != 0)
          type = "+"
        elsif (i % 2 != 0) && (j % 2 == 0)
          type = "+"
        elsif (i % 2 != 0) && (j % 2 != 0)
          type = "*"
        end
  
        if (i == 0) || (i == 1)
          board[i][j] = Tile.new(type, "blue")
        elsif (i == 3) || (i == 4)
          board[i][j] = Tile.new(type, "red")
        elsif i == 2
          # Set the specific pattern for row 3
          if j == 4
            board[i][j] = Tile.new(type, nil)  # Center tile is empty
          else
            board[i][j] = Tile.new(type, (j < 4 ? (j.even? ? "blue" : "red") : (j.even? ? "red" : "blue")))
          end
        end
      end
    end
    board
  end

  def get_colours
    players = {}
    selection = rand(2)
    if selection == 0
      players["PlayerA"] = "red"
      players["PlayerB"] = "blue"
    else
      players["PlayerA"] = "blue"
      players["PlayerB"] = "red"
    end
    players
  end
  
end
