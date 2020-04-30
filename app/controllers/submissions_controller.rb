class SubmissionsController < ApplicationController
  before_action :get_game, only: [:create]

  def create
    @submission = Submission.new(submission_params)
    @submission.game = @game
    authorize @submission
    if @submission.save
      redirect_to game_path(@game)
    else
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
