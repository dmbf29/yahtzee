class Game < ApplicationRecord
  has_many :submissions, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations
  belongs_to :winner, class_name: "User", optional: true

  def add_creator(user)
    participation = participations.where(user: user)
    if participation
      participation.creator = true
      participation.save
    else
      Participation.create(game: self, user: user, creator: true)
    end
  end
end
