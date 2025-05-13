class ApprovalMediator
  # Constructor
  def initialize
    # Creates an approval mediator object
  end

  # prompts the opponent to accept or deny a draw request
  def process_draw_request(requestingPlayer)
    # display a message asking the opponent to accept or deny the draw
    puts "#{requestingPlayer.id} has requested a draw. Opponent, do you accept? (y/n)"
    response = gets.chomp.downcase

    # returning true if the response is 'y', false otherwise
    response == 'y'
  end

  # asks both players if they want a rematch
  def begin_rematch
    puts "Rematch process initiated."
    # Prompt each player; only return true if both accept the rematch
    accepted = prompt_rematch("Player 1") && prompt_rematch("Player 2")

    # displaying appropriate message based on rematch acceptance
    if accepted
      puts "Both players accepted. Starting rematch."
    else
      puts "Rematch denied."
    end

    accepted
  end

  # prompts an individual player to accept or deny the rematch
  def prompt_rematch(player_id)
    # asking the specified player if they want to accept the rematch
    response = gets.chomp.downcase

    # returning true if the response is 'y'
    response == 'y'
  end
end
