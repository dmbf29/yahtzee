class Submission < ApplicationRecord
  belongs_to :game
  belongs_to :category
  belongs_to :user
  validates :value, numericality: true
  validates_uniqueness_of :category_id, scope: :user_id
  after_save :check_top_bonus, if: :top_six?

  def top_six?
    category.place <= 6
  end

  def check_top_bonus
    bonus_category = Category.top_bonus
    top_total = user.submissions.joins(:category).where('categories.place < ? AND game_id = ?', 7, game.id).pluck(:value).sum
    bonus_submission = Submission.where(
      category: bonus_category,
      user: user,
      game: game
    ).first_or_create
    bonus_submission.value = top_total < 63 ? 0 : 35
    bonus_submission.save
  end
end
