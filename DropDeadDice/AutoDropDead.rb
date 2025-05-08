class AutoDropDead
  
  def play_game(sides, dice_count, player_count)
    validator = GameValidate.new
    output = OutputDisplay.new
    
    # Moves to next game if parameters are not valid (players >= 2, dice >= 2, dice sides >= 6)
    return unless validator.validate_game?(sides, dice_count, player_count, output)

    players = Player.create_players(player_count, dice_count)
    game_state = GameState.new(players)
    game_outcome = GameOutcome.new(players)
    turn_manager = Turn.new(game_state, sides, output, Score.new, DiceManager.new(sides, Score.new))

    play_rounds(turn_manager, game_state, players)
    display_game_outcome(game_outcome, output)
  end

  private

  # Method to handle the game loop
  def play_rounds(turn_manager, game_state, players)
    while game_state.active_game?
      players.each do |player|
        turn_manager.process_turn(player)
      end
    end
  end

  # Method to display the final game outcome
  def display_game_outcome(game_outcome, output)
    if game_outcome.tie?
      output.display_tie(game_outcome.tied_players)
    else
      output.end(game_outcome.winner)
    end
  end
end
