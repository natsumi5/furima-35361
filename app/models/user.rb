class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: '漢字・ひらがな・カタカナ（全角）カタカナで入力して下さい。'}
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: '漢字・ひらがな・カタカナ（全角）で入力して下さい。'}
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'カタカナ（全角）で入力して下さい。'}
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'カタカナ（全角）で入力して下さい。'}
  validates :birthday, presence: true
end
