class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do
    validates :nickname
    validates :encrypted_password, :password, :password_confirmation,
              format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]/, message: '英字と数字の両方（半角）を含めて設定してください。' }
    validates :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '漢字・ひらがな・カタカナ（全角）で入力して下さい。' }
    validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '漢字・ひらがな・カタカナ（全角）で入力して下さい。' }
    validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'カタカナ（全角）で入力して下さい。' }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'カタカナ（全角）で入力して下さい。' }
    validates :birthday
  end
end
