class Reverter
  attr_accessor :player1_board, :player2_board

  # Constructor
  def initialize
    @player1_board = nil # Variable to store Player 1's board state
    @player2_board = nil # Variable to store Player 2's board state
  end

  # Method to store the current state of the board for a specific player
  def store_state(player_id, current_board)
    if player_id == 1
      @player1_board = current_board.clone # Store a copy of Player 1's board state
      return 'Board state saved for Player 1.'
    elsif player_id == 2
      @player2_board = current_board.clone # Store a copy of Player 2's board state
      return 'Board state saved for Player 2.'
    end
  end

  # Method to process an undo action after it has been approved
  def process_undo_move(player_id)
    if player_id == 1 && @player1_board
      return @player1_board # Return the previous state of Player 1's board
    elsif player_id == 2 && @player2_board
      return @player2_board # Return the previous state of Player 2's board
    else
      return "No board state available to undo for Player #{player_id}."
    end
  end
end
