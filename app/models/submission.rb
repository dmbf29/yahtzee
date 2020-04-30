class Submission < ApplicationRecord
  belongs_to :game
  belongs_to :category
  belongs_to :user
  validates_uniqueness_of :category_id, scope: :user_id
end
