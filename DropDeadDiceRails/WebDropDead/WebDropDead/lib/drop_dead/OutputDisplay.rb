class OutputDisplay
  
  attr_reader :messages
  
  def initialize
    @messages = []
  end
  
  # Display which player's turn it is
  def turn(player_number)
    @messages << "Player #{player_number}'s turn to roll."
  end

  # Display the results of a roll
  def display_roll(player_number, roll_results, points, score, active_dice, removed_dice)
    @messages << "Player #{player_number} rolled: #{roll_results}."
    @messages << "Points on roll: #{points}."
    @messages << "Player score: #{score}."
    @messages << "Remaining dice: #{active_dice}"

    if removed_dice > 0
      @messages << 'Player rolled a 2 or 5. No points are scored for this roll.'
    end
    @messages << ""
  end

  # Notify when a player is out
  def player_out(player_number)
    @messages << "Player #{player_number} is out of the game!"
    @messages << ""
  end

  # Display the game end results
  def end(winner)
    @messages << "Game over! The winner is Player #{winner.data[:number]} with a score of #{winner.data[:score]}."
    @messages << ""
  end

  # Display tie between players
  def display_tie(tied_players)
    @messages << "Game over! It's a tie between the following players:"
    tied_players.each do |player|
      @messages << "Player #{player.data[:number]} with a score of #{player.data[:score]}."
    end
    @messages << ""
  end

  # Display error message
  def display_error(message)
    @messages << "Error: #{message}"
    @messages << ""
  end
end
