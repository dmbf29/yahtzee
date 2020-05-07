class Game < ApplicationRecord
  has_many :submissions, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations
  belongs_to :winner, class_name: "User", optional: true
  before_validation :add_hex_code
  validates_uniqueness_of :code

  def to_param
    code
  end

  def add_hex_code
    self.code = SecureRandom.alphanumeric(6).upcase if code.nil?
  end

  def add_creator(user)
    participation = user_participation(user)
    if participation
      participation.creator = true
      participation.save
    else
      Participation.create(game: self, user: user, creator: true)
    end
  end

  def user_participation(user)
    participations.find_by(user: user)
  end

  def finish!
    participations.each do |participation|
      next unless participation.submissions.count == 15

      score = participation.user.submissions.where(game: self).pluck(:value).sum
      participation.final_score = score
      participation.save
    end
    self.winner = participations.order(final_score: :desc).first.user
    save
  end

  def nonbonus_submissions
    submissions.where.not(category: [Category.yahtzee_bonus, Category.top_bonus])
  end

  def full?
    participations.count >=5
  end
end
