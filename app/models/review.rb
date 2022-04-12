class Review < ApplicationRecord
  belongs_to :user
  belongs_to :portfolio
  validates :score, presence: true
  validates :content, presence: true
end
