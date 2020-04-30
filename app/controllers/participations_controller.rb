class ParticipationsController < ApplicationController
  before_action :get_game, only: [:create]

  def create
    @participation = Participation.new(participation_params)
    @participation.user = current_user
    @participation.game = @game
    authorize @participation
    if @participation.save
      redirect_to game_path(@game)
    else
      render 'games/show'
    end
  end

  private

  def participation_params
    params.require(:participation).permit(:place, :final_score, :creator)
  end

  def get_game
    @game = Game.find(params[:game_id])
  end
end
