class Score

  # Calculates points and dice to remove based on the roll results
  def calculate_points(roll_results)
    points = 0
    removed_dice = 0

    roll_results.each do |result|
      if result == 2 || result == 5
        removed_dice += 1
      else
        points += result
      end
    end

    # No points if player rolls 2 or 5
    points = 0 if removed_dice > 0

    [points, removed_dice]
  end
end
