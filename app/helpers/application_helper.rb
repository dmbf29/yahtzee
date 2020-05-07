module ApplicationHelper
  def get_submission(category, user)
    @submission = @game.submissions.find_by(category: category, user: user) || Submission.new
  end
end
