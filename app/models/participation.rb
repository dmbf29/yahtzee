class Participation < ApplicationRecord
  belongs_to :game
  belongs_to :user
  validates_uniqueness_of :game_id, scope: :user_id
  after_create :create_bonus_submissions

  def submissions
    game.submissions.where(user: user)
  end

  def nonbonus_submissions
    game.submissions.where(user: user).where.not(category: [Category.yahtzee_bonus, Category.top_bonus])
  end

  def create_bonus_submissions
    create_top_bonus
    create_yahtzee_bonus
  end

  def create_top_bonus
    Submission.create(
      category: Category.top_bonus,
      user: user,
      submitter: user,
      game: game,
      value: 0
    )
  end

  def create_yahtzee_bonus
    Submission.create(
      category: Category.yahtzee_bonus,
      user: user,
      submitter: user,
      game: game,
      value: 0
    )
  end
end
