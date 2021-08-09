require 'rails_helper'

RSpec.describe PurchaseShipping, type: :model do
  before do
    item = FactoryBot.create(:item)
    user = FactoryBot.create(:user)
    @purchase_shipping = FactoryBot.build(:purchase_shipping, user_id: user.id, item_id: item.id)
    sleep 0.1
  end

  describe '商品購入機能' do
    context '商品が購入できるとき' do
      it '全ての値が正しく入力されていれば購入できる' do
        expect(@purchase_shipping).to be_valid
      end
      it 'building_nameは空でも購入できる' do
        @purchase_shipping.building_name = ''
        expect(@purchase_shipping).to be_valid
      end
    end

    context '商品が購入できないとき' do
      it 'tokenが空では購入できない' do
        @purchase_shipping.token = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_codeが空では購入できない' do
        @purchase_shipping.postal_code = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeに"-"がない場合は購入できない' do
        @purchase_shipping.postal_code = 1111111
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include('Postal code ハイフン(-)を含めた半角数字で入力してください')
      end
      it 'prefecture_idが1の場合は購入できない' do
        @purchase_shipping.prefecture_id = 1
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it 'addressが空では購入できない' do
        @purchase_shipping.address = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Address can't be blank")
      end
      it 'address_numberが空では購入できない' do
        @purchase_shipping.address_number = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Address number can't be blank")
      end
      it 'phone_numberが空では購入できない' do
        @purchase_shipping.phone_number = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが半角数字でない場合は購入できない' do
        @purchase_shipping.phone_number = '０００００００００００'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include('Phone number 半角数字のみで入力してください')
      end
      it 'phone_numberが9桁以下では購入できない' do
        @purchase_shipping.phone_number = '123456789'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include('Phone number 半角数字のみで入力してください')
      end
      it 'phone_numberが12桁以上では購入できない' do
        @purchase_shipping.phone_number = '123456789012'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include('Phone number 半角数字のみで入力してください')
      end
      it 'user_idが紐づいていない場合は購入できない' do
        @purchase_shipping.user_id = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが紐づいていない場合は購入できない' do
        @purchase_shipping.item_id = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
