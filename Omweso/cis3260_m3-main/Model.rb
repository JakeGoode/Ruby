class Model
  # Instance Variables
  attr_accessor :board, :boardString, :ref, :rev, :init

  # Constructor
  def initialize
    # Initialize Game Initializer, Board, Referee, and Reverter
    @init = GameInitializer.new
    @board = Board.new
    @ref = Referee.new(@board)
    @rev = Reverter.new
    # Set up initial board state
    @board.board = @init.initialise_board
    @boardString = @board.to_s
  end

  # Starts the game by getting the board state and assigning player colors
  def start_game
    # Get initial player colors and board state
    colors = @init.get_colours
    @boardString = @board.to_s
    { colors: colors, board_state: @boardString }
  end

  # Processes a move from the view system, handling empty values for repeated capture moves
  def move(initialSquare, destinationSquare, player, next_player, captureType)
    # Check if either square is empty, indicating the player chose not to make a repeated capture move
    if initialSquare.nil? || destinationSquare.nil? || initialSquare.empty? || destinationSquare.empty?
      return { move_type: "no_move", board_state: @board.to_s }
    end

    # if capture type is retrieved from player
    if !captureType.nil?
      # Perform the capture
      @ref.capture_pieces(initialSquare, destinationSquare, captureType)

      @board.move(initialSquare, destinationSquare)
      
      # Check if the game should end after capture
      game_end = @ref.end_check([player, next_player])
      return { move_type: "capture", board_state: @board.to_s, capture_type: captureType, game_end: game_end } if game_end
    end
  
    # Validate the move with the player
    move_type = @ref.validate_move(initialSquare, destinationSquare, player)
    
    if move_type == "capture"
      # Determine the capture type (approach or retreat)
      captureType = @ref.capture_type(initialSquare, destinationSquare, player)
   
      # If both capture types are available, prompt the view for player choice
      if captureType == "both"
        return { move_type: "capture", board_state: @board.to_s, capture_type: captureType, capture_options: ["advancing", "retreating"] }
      end

      # Perform the capture
      @ref.capture_pieces(initialSquare, destinationSquare, captureType)

      @board.move(initialSquare, destinationSquare)
      
      # Check if the game should end after capture
      game_end = @ref.end_check([player, next_player])
      return { move_type: "capture", board_state: @board.to_s, capture_type: captureType, game_end: game_end } if game_end

    elsif move_type == "nonCapture"
      # Non-capturing move, update the board
      @board.move(initialSquare, destinationSquare)
    else
      # Invalid move
      return { move_type: "invalid", board_state: @board.to_s }
    end
  
    # Update board state after move
    @boardString = @board.to_s
    { move_type: move_type, board_state: @boardString, capture_type: captureType, game_end: false }
  end

  # Processes a confirmed forfeit by a player, updating and returning the game results
  def forfeit_confirmation(player)
    # Mark the game as forfeited by the given player
    game_result = { result: "forfeit", forfeiting_player: player.get_id }
    
    # Identify the winner as the other player
    other_player_id = player.get_id == 1 ? 2 : 1
    game_result[:winner] = other_player_id

    # Return game result data for the view to handle display
    game_result
  end

  # Processes an undo request response and restores the previous board state
  def process_undo_response(player)
    # Retrieve previous board state from reverter
    previous_state = @rev.process_undo_move(player.get_id)
    
    if previous_state.is_a?(String)
      # If there's no saved state, return message
      { undo_status: "failed", message: previous_state }
    else
      # Restore board state to the previous state
      @board = previous_state
      @boardString = @board.to_s
      { undo_status: "success", board_state: @boardString }
    end
  end
end
