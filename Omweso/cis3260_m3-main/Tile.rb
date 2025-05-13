class Tile
  attr_accessor :type, :colour

  def initialize(type, colour = nil)
    @type = type
    @colour = colour
  end

  def get_colour
    @colour
  end

  def get_type
    @type
  end

  def set_colour(colour)
    @colour = colour
  end

  def to_s
    case @colour
    when "blue"
      "O"
    when "red"
      "●"
    else
      "0"  # Representing an empty tile as "0"
    end
  end
end
