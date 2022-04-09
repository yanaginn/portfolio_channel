class Portfolio < ApplicationRecord
  has_many :reviews, dependent: :destroy
  attachment :image
  belongs_to :user

  with_options presence: true do
    validates :title
    validates :body
    validates :image
  end
end
