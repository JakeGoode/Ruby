class GameOutcome
  attr_reader :players

  def initialize(players)
    @players = players
  end

  # Determines if the game is a tie
  def tie?
    highest_score = players.map { |player| player.data[:score] }.max
    players.count { |player| player.data[:score] == highest_score } > 1
  end

  # Finds the winner
  def winner
    highest_score_player = players.max_by { |player| player.data[:score] }
    highest_score_player
  end

  # Returns players who are tied
  def tied_players
    highest_score = players.map { |player| player.data[:score] }.max
    players.select { |player| player.data[:score] == highest_score }
  end
end
