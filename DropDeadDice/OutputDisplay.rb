class OutputDisplay
  
  # Display which player's turn it is
  def turn(player_number)
    puts "Player #{player_number}'s turn to roll."
  end

  # Display the results of a roll
  def display_roll(player_number, roll_results, points, score, active_dice, removed_dice)
    puts "Player #{player_number} rolled: #{roll_results}."
    puts "Points on roll: #{points}."
    puts "Player score: #{score}."
    puts "Remaining dice: #{active_dice}"

    if removed_dice > 0
      puts "Player rolled a 2 or 5. No points are scored for this roll."
    end
    puts
  end

  # Notify when a player is out
  def player_out(player_number)
    puts "Player #{player_number} is out of the game!"
    puts
  end

  # Display the game end results
  def end(winner)
    puts "Game over! The winner is Player #{winner.data[:number]} with a score of #{winner.data[:score]}."
    puts
  end

  # Display tie between players
  def display_tie(tied_players)
    puts "Game over! It's a tie between the following players:"
    tied_players.each do |player|
      puts "Player #{player.data[:number]} with a score of #{player.data[:score]}."
    end
    puts
  end

  # Display error message
  def display_error(message)
    puts "Error: #{message}"
    puts
  end
end
