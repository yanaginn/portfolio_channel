class Portfolio < ApplicationRecord
  has_many :reviews, dependent: :destroy
  attachment :image
  belongs_to :user

  with_options presence: true do
    validates :title
    validates :body
    validates :image
  end

  def avg_score
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f
    else
      0.0
    end
  end

  def review_score_percentage
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f*100/5
    else
      0.0
    end
  end
end
