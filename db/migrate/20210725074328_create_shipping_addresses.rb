class CreateShippingAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_addresses do |t|
      t.string :postal_code,        null: false
      t.integer :prefecture_id,     null: false
      t.string :address,            null: false
      t.string :address_number,     null: false
      t.string :building_name
      t.string :phone_number,       null: false
      t.references :purchase,       foreign_key: true
      t.timestamps
    end
  end
end
