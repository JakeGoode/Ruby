class Player
  # Instance Variables
  attr_accessor :colour, :id

  # Constructors
  def initialize(colour, id)
    # Creates a player with a color and id
    @colour = colour  
    @id = id          
  end

  # Method to return the player's color
  def get_colour
    @colour 
  end

  # Method to return the player's ID
  def get_id
    @id  
  end
end
