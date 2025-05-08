class Player
  attr_accessor :data

  def initialize(player_number, dice_count)
    @data = {
      number: player_number,
      score: 0,
      active_dice: dice_count
    }
  end

  # Creates a list of all players in the game
  def self.create_players(player_count, dice_count)
    (1..player_count).map { |i| new(i, dice_count) }
  end

  # Updates the player's score
  def update_score(points)
    @data[:score] += points
  end

  # Reduces the number of active dice
  def reduce_dice(count)
    @data[:active_dice] -= count
  end

  # Checks if the player is out (i.e. no dice left)
  def out?
    @data[:active_dice] <= 0
  end
end
