class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews, dependent: :destroy
  has_many :portfolios, dependent: :destroy
  attachment :profile_image

  def self.guest
    find_or_create_by!(username: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.username = "guestuser"
    end
  end

  def self.search_for(content, method)
    if method == 'perfect'
      User.where(username: content)
    elsif method == 'forward'
      User.where('username LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('username LIKE ?', '%' + content)
    else
      User.where('username LIKE ?', '%' + content + '%')
    end
  end

  validates :username, presence: true
end
