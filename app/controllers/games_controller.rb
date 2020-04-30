class GamesController < ApplicationController
  before_action :get_game, only: [:show]

  def create
    @game = Game.new(game_params)
    authorize @game
    if @game.save
      redirect_to game_path(@game)
    else
      render 'pages/home'
    end
  end

  def show
    authorize @game
  end

  private

  def game_params
    params.require(:game).permit(:code, :name)
  end

  def get_game
    @game = Game.find(params[:id])
  end
end
