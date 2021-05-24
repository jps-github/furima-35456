class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  with_options presence: true do
    validates :nickname
    validates :birthday

    with_options format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: 'is invalid. Input full-width characters' } do
      validates :last_name
      validates :first_name
    end

    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters' } do
      validates :last_name_katakana
      validates :first_name_katakana
    end
  end

  validates :password,
            format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}/, message: 'is invalid. Include both letters and numbers' }
end
