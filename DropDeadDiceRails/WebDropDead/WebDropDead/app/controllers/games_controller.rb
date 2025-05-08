class GamesController < ApplicationController
  
  #require "#{Rails.root}/lib/drop_dead/load_drop_dead.rb"
  
  def play_game
  end

  def submit_game
    # Retrieve the parameters for the game through to form
    sides = params[:sides].to_i
    dice_count = params[:dice_count].to_i
    player_count = params[:player_count].to_i

    @errors = []

    # Validation Check
    @errors << 'Two or more players are required to play the game.' if player_count < 2
    @errors << 'Two or more dice are required to play the game.' if dice_count < 2
    @errors << 'The dice must have six or more sides to play the game.' if sides < 6

    # Play a new game if no errors present
    if @errors.empty?
      game = AutoDropDead.new
      @game_output = game.play_game(sides, dice_count, player_count)
    end

    # Render the play_game view with game results
    render :play_game
  end
end
