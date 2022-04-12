class Tag < ApplicationRecord
  has_many :portfolio_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :portfolios, through: :portfolio_tags

  scope :merge_portfolios, -> (tags){ }

  def self.search_portfolios_for(content, method)

    if method == 'perfect'
      tags = Tag.where(name: content)
    elsif method == 'forward'
      tags = Tag.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      tags = Tag.where('name LIKE ?', '%' + content)
    else
      tags = Tag.where('name LIKE ?', '%' + content + '%')
    end

    return tags.inject(init = []) {|result, tag| result + tag.portfolios}

  end
end
