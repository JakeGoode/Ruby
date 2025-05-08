class Dice
  
  def initialize(sides)
    @sides = sides
  end

  # Rolls the players available dice
  def roll(count)
    Array.new(count) { rand(1..@sides) }
  end
end
