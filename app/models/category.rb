class Category < ApplicationRecord
  has_many :submissions, dependent: :destroy

  def get_total(game, user)
    case name
    when "Total"
      user.submissions.joins(:category).where('categories.place < ? AND game_id = ?', 7, game.id).pluck(:value).sum
    when "Total Top Half"
      user.submissions.joins(:category).where('categories.place < ? AND game_id = ?', 8, game.id).pluck(:value).sum
    when "Total Bot. Half"
      # user.submissions.joins(:category).where('categories.place < ?', 7).pluck(:value).sum
    when "Total Score"
      # user.submissions.joins(:category).where('categories.place < ?', 7).pluck(:value).sum
    end
  end

  def self.top_bonus
    find_by_place(8)
  end
end
