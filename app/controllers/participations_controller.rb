class ParticipationsController < ApplicationController
  before_action :set_game, only: [:create]
  # before_action :set_participation, only: [:update]
  # before_action :set_table_values, only: [:order]

  def create
    @participation = Participation.new
    authorize @participation
    if params[:participation]
      @participation.user = User.find(params[:participation][:user_id])
    else
      @participation.user = current_user
    end
    @participation.game = @game
    if @participation.save
      set_table_values
      GameChannel.broadcast_to(
        @game,
        table: render_to_string(partial: "games/table"),
        new_player: render_to_string(partial: "participations/list"),
        big_boys: render_to_string(partial: "games/big_boys"),
        remove_list: render_to_string(partial: "participations/remove_modal"),
        finished: set_leaderboard
      )
      redirect_to game_path(@game)
    else
      set_table_values
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
      table: render_to_string(partial: "games/table"),
      new_player: render_to_string(partial: "participations/list")
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
    @game = Game.find_by(code: params[:game_id])
  end

  def set_table_values
    @participations = @game.participations.order(place: :asc)
    @categories = Category.order(place: :asc)
    @top_categories = @categories.where(top_half: true)
    @bottom_categories = @categories.where(top_half: false)
    @participation = @game.user_participation(current_user) || Participation.new
    @big_boys = (User.where.not(big_boys: 0) + @game.users).uniq.sort_by(&:big_boys).reverse
  end

  def set_leaderboard
    @leaderboard = Participation.includes(:user).where.not(final_score: nil).order(final_score: :desc).first(10)
    @others = Participation.includes(:user)
    .where.not(final_score: nil)
    .where.not(id: @leaderboard)
    .where.not(user_id: @leaderboard.pluck(:user_id))
    .order(final_score: :desc).uniq(&:user_id)
    @all_participations = Participation.where.not(final_score: nil).order(final_score: :desc)
    @leaderboard += @others
    render_to_string(partial: "games/leaderboard")
  end
end
