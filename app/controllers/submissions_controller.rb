class SubmissionsController < ApplicationController
  before_action :set_game, only: [:create, :update, :cursor_place]
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
        message: render_to_string(partial: "submissions/message", locals: { submission: @submission }),
        finished: @game.winner ? set_leaderboard : false,
        cursor_moved: true,
        cursor_place: "submission_value-#{@submission.category.id}-#{@game.user_participation(@submission.user).id}",
        participation_place: @participation.place,
        user_id: current_user.id
      )
      head :ok
    else
      set_leaderboard
      @big_boys = (User.where.not(big_boys: 0) + @game.users).uniq.sort_by(&:big_boys).reverse
      flash[:alert] = @submission.errors.full_messages.first
      render 'games/show'
    end
  end

  def update
    @submission = Submission.find(params[:id])
    authorize @submission
    if submission_params[:value].blank?
      @submission.destroy
      GameChannel.broadcast_to(
        @game,
        table: render_to_string(partial: "games/table"),
        message: render_to_string(partial: "submissions/destroy_message", locals: { submission: @submission }),
        finished: @game.winner ? set_leaderboard : false,
        cursor_moved: true,
        cursor_place: "submission_value-#{@submission.category.id}-#{@game.user_participation(@submission.user).id}",
        participation_place: @participation.place,
        user_id: current_user.id
      )
      head :ok
    elsif @submission.update(submission_params)
      GameChannel.broadcast_to(
        @game,
        table: render_to_string(partial: "games/table"),
        message: render_to_string(partial: "submissions/message", locals: { submission: @submission }),
        finished: @game.winner ? set_leaderboard : false,
        cursor_moved: true,
        cursor_place: "submission_value-#{@submission.category.id}-#{@game.user_participation(@submission.user).id}",
        participation_place: @participation.place,
        user_id: current_user.id
      )
      head :ok
    else
      set_table_values
      @big_boys = (User.where.not(big_boys: 0) + @game.users).uniq.sort_by(&:big_boys).reverse
      set_leaderboard
      render 'games/show'
    end
  end

  def cursor_place
    authorize @game
    unless params[:participation_place].blank?
      GameChannel.broadcast_to(
        @game,
        cursor_moved: true,
        cursor_place: params[:cursor_place_id],
        participation_place: params[:participation_place],
        user_id: params[:user_id]
      )
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
