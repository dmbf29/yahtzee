class GamesController < ApplicationController
  before_action :set_game, only: [:show, :search]
  skip_after_action :verify_authorized, only: [:search]
  before_action :set_table_values, only: [:show]

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
    @participations = @game.participations.order(place: :asc)
    @categories = Category.order(place: :asc)
    @top_categories = @categories.where(top_half: true)
    @bottom_categories = @categories.where(top_half: false)
    @participation = @game.user_participation(current_user) || Participation.new
  end

  def search
    if @game
      redirect_to game_path(@game)
    else
      flash[:alert] = "Could not find game with that code."
      redirect_to root_path
    end
  end

  def index
    @games = policy_scope(Game).order(created_at: :desc)
  end

  private

  def game_params
    params.require(:game).permit(:code, :name)
  end

  def set_game
    @game = Game.find_by(code: params[:id])
  end

  def set_table_values
    @participations = @game.participations.order(place: :asc)
    @categories = Category.order(place: :asc)
    @top_categories = @categories.where(top_half: true)
    @bottom_categories = @categories.where(top_half: false)
    @participation = @game.user_participation(current_user) || Participation.new
  end
end
