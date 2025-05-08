This program runs the drop dead dice game for 2 or more players. The dice can be 2 or more and the number of
sides per dice can be 6 or more. Error handling checks if there are at least 2 players, 2 dice, and 6 sides to
the dice. The program works as outlined in the Assignment document. Multiple game's can be ran and will not stop
the program if one of the games did not have valid parameters; it will just move to the next game if available.
The following ruby code was used to test the program.

require_relative "load_drop_dead.rb"

game1 = AutoDropDead.new

#game2 = AutoDropDead.new

game1.play_game(6, 5, 2)

#game2.play_game(6, 5, 2)