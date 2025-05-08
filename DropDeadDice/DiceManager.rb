class DiceManager
  
  def initialize(sides, score_manager)
    @sides = sides
    @score_manager = score_manager
  end

  # Rolls dice for a player, calculates the points, and handles dice removal
  def process_dice(player)
    dice = Dice.new(@sides)
    roll_results = dice.roll(player.data[:active_dice])
    points, removed_dice = @score_manager.calculate_points(roll_results)

    # Update player dice and score based on the roll
    if removed_dice > 0
      player.reduce_dice(removed_dice)
    else
      player.update_score(points)
    end

    { roll_results: roll_results, points: points, removed_dice: removed_dice }
  end
end
