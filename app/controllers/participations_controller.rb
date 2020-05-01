class ParticipationsController < ApplicationController
  before_action :set_game, only: [:create]

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

  def destroy
    @participation = Participation.find(params[:id])
    authorize @participation
    @participation.destroy
    redirect_to game_path(@participation.game)
  end

  private

  def participation_params
    params.require(:participation).permit(:place, :final_score, :creator)
  end

  def set_game
    @game = Game.find_by(code: params[:id])
  end
end
