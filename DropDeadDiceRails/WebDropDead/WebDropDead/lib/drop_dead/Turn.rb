class Turn
  
  def initialize(game_state, sides, output, score_manager, dice_manager)
    @game_state = game_state
    @output = output
    @score_manager = score_manager
    @dice_manager = dice_manager
  end

  # Organizes the player's turn
  def process_turn(player)
    return if player.out?

    # Notify player's turn
    @output.turn(player.data[:number])

    loop do
      # Delegate dice processing to DiceManager
      dice_result = @dice_manager.process_dice(player)

      # Display roll results and player state
      @output.display_roll(
        player.data[:number],
        dice_result[:roll_results],
        dice_result[:points],
        player.data[:score],
        player.data[:active_dice],
        dice_result[:removed_dice]
      )

      break if dice_result[:removed_dice].positive? || player.out?
    end

    # Notify if player is out
    @output.player_out(player.data[:number]) if player.out?
  end
end
