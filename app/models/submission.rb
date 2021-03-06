class Submission < ApplicationRecord
  belongs_to :game
  belongs_to :category
  belongs_to :user
  belongs_to :submitter, class_name: "User", foreign_key: "submitter_id"
  validates_as_paranoid
  validates :value, numericality: true
  validates_uniqueness_of_without_deleted :category_id, scope: [:user_id, :game_id]
  validate :fixed_value, if: :category_fixed?
  after_save :check_top_bonus, if: :top_six?
  after_save :check_game_end
  acts_as_paranoid

  def top_six?
    category.place <= 6
  end

  def category_fixed?
    category.fixed_value
  end

  def fixed_value
    errors.add(:value, "This has a fixed value") unless value == category.value || value == 0 || category.place == 17
  end

  def check_top_bonus
    bonus_category = Category.top_bonus
    top_total = user.submissions.joins(:category).where('categories.place < ? AND game_id = ?', 7, game.id).pluck(:value).sum
    bonus_submission = Submission.where(
      category: bonus_category,
      user: user,
      submitter: user,
      game: game
    ).first_or_create
    bonus_submission.value = top_total < 63 ? 0 : 35
    bonus_submission.save
  end

  def check_game_end
    user_count = game.participations.count
    user_turns = 15
    game.finish! if game.submissions.count == (user_count * user_turns)
  end
end
