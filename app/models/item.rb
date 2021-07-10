class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :description
      with_options numericality: { other_than: 1 } do
        validates :category_id
        validates :status_id
        validates :burden_id
        validates :prefecture_id
        validates :day_to_ship_id
      end
        validates :price
  end

  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :burden
  belongs_to :prefecture
  belongs_to :day_to_ship
end
