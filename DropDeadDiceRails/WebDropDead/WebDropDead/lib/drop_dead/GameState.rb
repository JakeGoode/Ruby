class GameState
  attr_reader :players

  def initialize(players)
    @players = players
  end

  # Tracks the active state of the game
  def active_game?
    players.any? { |player| !player.out? }
  end
end
