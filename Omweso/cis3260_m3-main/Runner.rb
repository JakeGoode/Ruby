require_relative 'ApprovalMediator'
require_relative 'Board'
require_relative 'GameInitializer'
require_relative 'Model'
require_relative 'Player'
require_relative 'Referee'
require_relative 'Reverter'
require_relative 'Tile'
require_relative 'View' 


class Runner
    def initialize
        # Initialize the View, which sets up the Model, ApprovalMediator, and Players
        @view = View.new
    end

    def start
        # Start the game by calling the start_game method in the View
        @view.start_game
    end
end
  
# To run the game
game = Runner.new
game.start
  
