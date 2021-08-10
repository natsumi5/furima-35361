class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, :password_confirmation,
            format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]/, message: '英字と数字の両方（半角）を含めて設定してください。' }
  with_options presence: true do
    validates :nickname
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '漢字・ひらがな・カタカナ（全角）で入力して下さい。' } do
      validates :last_name
      validates :first_name
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: 'カタカナ（全角）で入力して下さい。' } do
      validates :last_name_kana
      validates :first_name_kana
    end
    validates :birthday
  end

  has_many :items
  has_one :purchase
end
