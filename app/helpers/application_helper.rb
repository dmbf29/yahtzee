module ApplicationHelper
  def get_submission(category, user)
    @submission = @game.submissions.find_by(category: category, user: user) || Submission.new
  end

  def display_average_score(user)
    if @users_displayed.include?(user.id)
      ''
    else
      @users_displayed << user.id
      user.average_score
    end
  end

  def display_index(index, participation)
    if index <= 9
      "#{index + 1}. "
    else
      "#{@all_participations.index(participation) + 1}. "
    end
  end
end
