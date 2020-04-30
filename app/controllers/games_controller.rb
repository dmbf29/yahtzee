class GamesController < ApplicationController
  before_action :get_game, only: [:show]

  def create
    @game = Game.new(game_params)
    authorize @game
    if @game.save
      @game.add_creator(current_user)
      redirect_to game_path(@game)
    else
      render 'pages/home'
    end
  end

  def show
    authorize @game
    @users = @game.users
    @categories = Category.order(place: :asc)
    @top_categories = @categories.where(top_half: true)
    @bottom_categories = @categories.where(top_half: false)
    @participation = @game.user_participation(current_user) || Participation.new
  end

  private

  def game_params
    params.require(:game).permit(:code, :name)
  end

  def get_game
    @game = Game.find(params[:id])
  end
end
