class GameValidate
  
  # Validates gameplay requirements
  def validate_game?(sides, dice_count, player_count, output)
    if player_count < 2
      output.display_error("Two or more players are required to play the game.")
      return false
    end

    if dice_count < 2
      output.display_error("Two or more dice are required to play the game.")
      return false
    end

    if sides < 6
      output.display_error("The dice must have six or more sides to play the game.")
      return false
    end

    true  # Validation passed
  end
end
