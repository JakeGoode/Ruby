class View
  # Instance Variables
  attr_accessor :p1, :p2, :model, :med

  # Constructors
  def initialize
    @model = Model.new
    @med = ApprovalMediator.new
    colors = @model.start_game[:colors]  # Extract colors from the returned hash
    
    if colors.nil? || colors["PlayerA"].nil? || colors["PlayerB"].nil?
      puts "Error: Player colors not assigned correctly."
    end

    @p1 = Player.new(colors["PlayerA"], 1)
    @p2 = Player.new(colors["PlayerB"], 2)
  end

  # Methods
  def start_game
    # Starts the game by displaying the initial board and player piece colors
    display_start(@model.boardString, @p1.get_colour)
    game_loop
  end

  def input_move(initialSquare, destinationSquare, player, next_player)
    # Start a move with the initial and destination squares and the current player
    move_result = @model.move(initialSquare, destinationSquare, player, next_player, nil)

    if move_result[:capture_type] == "both"
      puts "Which type of capture would you like? (A for approach or R for retreat):"
      capture_type = gets.chomp.upcase
      if capture_type == 'A'
        move_result = @model.move(initialSquare, destinationSquare, player, next_player, "advancing")
        puts "Approach capture performed"
        display_board(move_result[:board_state])
      elsif capture_type == 'R'
        move_result = @model.move(initialSquare, destinationSquare, player, next_player, "retreating")
        puts "Retreat capture performed"
        display_board(move_result[:board_state])
      end
      return true

    elsif move_result[:move_type] == "capture"
      if move_result[:capture_type] == "advancing"
        puts "Approach capture performed"
        display_board(move_result[:board_state])
      elsif move_result[:capture_type] == "retreating"
        puts "Retreat capture performed"
        display_board(move_result[:board_state])
      end
      return true

    elsif move_result[:move_type] == "nonCapture"
      puts "Move completed without capture."
      display_board(move_result[:board_state])
      return true

    else
      puts "Invalid move."
      return false

    end
  end
  

  def display_start(boardString, color)
    # Displays the board and the player's piece color
    puts boardString
  end

  def display_board(boardString)
    # Displays the board to the players
    puts boardString
  end

  def offer_draw
    # Initiates a draw offer to the opponent
    puts "Player has offered a draw. Opponent, do you accept? (y/n)"
    response = gets.chomp.downcase
    if @med.process_draw_request(response)
      display_game_ended_as_draw
    else
      display_draw_request_denied
    end
  end

  def display_game_ended_as_draw
    # Shows a game-ended-in-draw screen
    puts "The game has ended in a draw."
  end

  def display_draw_request_denied
    # Shows a denied draw request to the players
    puts "Draw request denied."
  end

  def game_ended(winnerId)
    # Displays the winner and starts the rematch prompt process
    puts "Player #{winnerId} wins!"
    puts "Would you like a rematch? (y/n)"
    if @med.begin_rematch
      start_game
    else
      display_rematch_denied
    end
  end

  def display_rematch_denied
    # Shows a denied rematch prompt
    puts "Rematch denied. Game over."
  end

  def request_forfeit(player)
    # Displays a forfeit confirmation prompt
    puts "Player #{player.get_id} has forfeited the game."
    game_ended(player.get_id == 1 ? 2 : 1)  # The other player wins
  end

  def request_undo_move(player)
    # Prompts an undo request to the other player
    puts "Player #{player.get_id} has requested an undo. Opponent, do you accept? (y/n)"
    response = gets.chomp.downcase
    if response == 'y'
      @model.process_undo_response(player)
      puts "Undo request accepted."
    else
      puts "Undo request denied."
    end
  end

  private

  def game_loop
    current_player = @p1
    next_player = @p2
    loop do
      puts "Player #{current_player.get_id}'s Turn (#{current_player.get_colour.capitalize})"
      puts "Choose a piece to move (e.g. D3) or type U to request undo or F to forfeit:"
      action = gets.chomp.upcase
      case action
      when 'U'
        request_undo_move(current_player)
      when 'F'
        request_forfeit(current_player)
        break
      when /^[A-I][1-5]$/ 
        loop do
          puts "#{action} selected. Choose a destination square (e.g. E3) or type U to select a different piece:"
          destination = gets.chomp.upcase
          # user selects U
          if destination == "U"
            break
          end

          move_successful = input_move(action, destination, current_player, next_player)
          if move_successful
            #update ref board
            @model.ref.board = @model.board
            puts @model.rev.store_state(current_player.get_id, @model.board)
            if !@model.ref.check_repeated_capture(destination)
              # Switch player turn
              current_player = current_player == @p1 ? @p2 : @p1
              break
            else
              puts "You can capture with the piece again"
              action = destination
            end
          else
            next
          end
        end
      else
        puts "Invalid input. Please try again."
        next # keep same player's turn
      end
    end
  end
end
