class SubmissionsController < ApplicationController
  before_action :set_game, only: [:create, :update]
  before_action :set_table_values, only: [:create, :update]

  def create
    @submission = Submission.new(submission_params)
    @submission.game = @game
    @submission.submitter = current_user
    authorize @submission
    if @submission.save
      GameChannel.broadcast_to(
        @game,
        table: render_to_string(partial: "games/table"),
        message: render_to_string(partial: "submissions/message", locals: { submission: @submission })
      )
      redirect_to game_path(@game)
    else
      flash[:alert] = @submission.errors.full_messages.first
      render 'games/show'
    end
  end

  def update
    @submission = Submission.find(params[:id])
    authorize @submission
    if @submission.update(submission_params)
      GameChannel.broadcast_to(
        @game,
        table: render_to_string(partial: "games/table"),
        message: render_to_string(partial: "submissions/message", locals: { submission: @submission })
      )
      redirect_to game_path(@game)
    else
      render 'games/show'
    end
  end

  private

  def submission_params
    params.require(:submission).permit(:value, :category_id, :user_id)
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
    @leaderboard = Participation.where.not(final_score: nil).order(final_score: :desc).first(5)
    @big_boys = User.where.not(big_boys: 0)
  end
end
