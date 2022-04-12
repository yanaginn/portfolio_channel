class Portfolio < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :portfolio_tags, dependent: :destroy
  has_many :tags, through: :portfolio_tags
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

  def save_tags(saveportfolio_tags)
    # 現在のユーザーの持っているskillを引っ張ってきている
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 今portfolioが持っているタグと今回保存されたものの差をすでにあるタグとする。古いタグは消す。
    old_tags = current_tags - saveportfolio_tags
    # 今回保存されたものと現在の差を新しいタグとする。新しいタグは保存
    new_tags = saveportfolio_tags - current_tags

    # Destroy old taggings:
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    # Create new taggings:
    new_tags.each do |new_name|
      portfolio_tag = Tag.find_or_create_by(name:new_name)
      # 配列に保存
      self.tags << portfolio_tag
    end
  end

  def self.search_for(content, method)
      if method == 'perfect'
        Portfolio.where(title: content)
      elsif method == 'forward'
        Portfolio.where('title LIKE ?', content+'%')
      elsif method == 'backward'
        Portfolio.where('title LIKE ?', '%'+content)
      else
        Portfolio.where('title LIKE ?', '%'+content+'%')
      end
  end
end
