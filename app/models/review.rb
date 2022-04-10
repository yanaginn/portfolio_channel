class Review < ApplicationRecord
  belongs_to :user
  belongs_to :portfolio
  validates :score, presence: true
end
