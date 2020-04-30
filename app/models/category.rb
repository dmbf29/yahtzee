class Category < ApplicationRecord
  has_many :submissions, dependent: :destroy
end
