class UsersController < ApplicationController
  before_action :set_user, only: [:update, :big_boys]

  def update
    @game = Game.find(params[:game_id])
    authorize @user
    if @user.update(user_params)
      @participations = @game.participations.order(place: :asc)
      GameChannel.broadcast_to(
        @game,
        new_player: render_to_string(partial: "participations/list")
      )
      head :ok
    else
      flash[:alert] = @user.errors.full_messages.first
      redirect_to game_path(@game)
    end
  end

  def big_boys
    @game = Game.find(params[:game_id])
    authorize @user
    if @user.update(user_params)
      @big_boys = (User.where.not(big_boys: 0) + @game.users).uniq.sort_by(&:big_boys).reverse
      GameChannel.broadcast_to(
        @game,
        big_boys: render_to_string(partial: "games/big_boys")
      )
      head :ok
    else
      flash[:alert] = @user.errors.full_messages.first
      redirect_to game_path(@game)
    end
  end

  private

  def user_params
    params.require(:user).permit(:big_boys, :name, :email, :time_zone)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
