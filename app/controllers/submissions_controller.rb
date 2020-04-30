class SubmissionsController < ApplicationController
  before_action :get_game, only: [:create, :update]

  def create
    @submission = Submission.new(submission_params)
    @submission.game = @game
    authorize @submission
    if @submission.save
      redirect_to game_path(@game)
    else
      @users = @game.users
      @categories = Category.order(place: :asc)
      @top_categories = @categories.where(top_half: true)
      @bottom_categories = @categories.where(top_half: false)
      @participation = @game.user_participation(current_user) || Participation.new
      render 'games/show'
    end
  end

  def update
    @submission = Submission.find(params[:id])
    authorize @submission
    if @submission.update(submission_params)
      redirect_to game_path(@game)
    else
      @users = @game.users
      @categories = Category.order(place: :asc)
      @top_categories = @categories.where(top_half: true)
      @bottom_categories = @categories.where(top_half: false)
      @participation = @game.user_participation(current_user) || Participation.new
      render 'games/show'
    end
  end

  private

  def submission_params
    params.require(:submission).permit(:value, :category_id, :user_id)
  end

  def get_game
    @game = Game.find(params[:game_id])
  end
end
