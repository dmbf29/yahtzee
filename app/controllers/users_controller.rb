class UsersController < ApplicationController
  before_action :set_user, only: [:update]

  def update
    @game = Game.find(params[:game_id])
    if @user.update(user_params)
      redirect_to game_path(@game)
    else
      flash[:alert] = @user.errors.full_messages.first
      redirect_to game_path(@game)
    end
  end

  private

  def user_params
    params.require(:user).permit(:big_boys, :name, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
