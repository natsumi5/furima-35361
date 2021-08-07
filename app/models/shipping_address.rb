class ShippingAddress < ApplicationRecord
  has_one :shipping_addresses

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
