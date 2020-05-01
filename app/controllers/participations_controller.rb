class ParticipationsController < ApplicationController
  before_action :set_game, only: [:create]
  # before_action :set_participation, only: [:update]
  # before_action :set_table_values, only: [:order]

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

  def order
    @game = Game.find(params[:game][:id])
    authorize @game
    set_table_values
    params[:participation][:ids].each_with_index do |id, index|
      Participation.find(id).update(place: index + 1)
    end
    GameChannel.broadcast_to(
      @game,
      render_to_string(partial: "games/table")
    )
    render status: 200, json: @game.to_json
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

  def set_participation
    Participation.find(params[:id])
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
