class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :participations, dependent: :destroy
  has_many :games, through: :participations
  has_many :submissions
  has_many :games_won, source: :games, foreign_key: :winner_id
  validates :name, presence: true

  def average_score
    finished_games = participations.where.not(final_score: nil)
    if finished_games.any?
      (finished_games.pluck(:final_score).sum / finished_games.count).round(2)
    else
      'n/a'
    end
  end
end
