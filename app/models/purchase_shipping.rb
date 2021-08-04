class PurchaseShipping
  include ActiveModel::Model
  attr_accessor :token, :postal_code, :prefecture_id, :address, :address_number, :building_name, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :token
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: "ハイフン(-)を含めた半角数字で入力してください"} 
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :address
    validates :address_number
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "半角数字のみで入力してください" }
  end


  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, address: address, address_number: address_number, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end