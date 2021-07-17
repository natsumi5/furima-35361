require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品が出品できるとき' do
      it 'name,description,category_id,status_id,burden_id,prefecture_id,day_to_ship_id,price,user_idが存在すれば登録できる' do
        expect(@item).to be_valid
      end
      it 'nameが40文字以内の場合登録できる' do
        a = 'a'
        a_40 = a * 40
        @item.name = a_40
        expect(@item).to be_valid
      end
      it 'descriptionが1000文字以内の場合登録できる' do
        a = 'a'
        a_1000 = a * 1000
        @item.description = a_1000
        expect(@item).to be_valid
      end
      it 'priceが300以上の場合登録できる' do
        @item.price = 300
        expect(@item).to be_valid
      end
      it 'priceが9999999以下の場合登録できる' do
        @item.price = 9_999_999
        expect(@item).to be_valid
      end
    end

    context '商品が出品できないとき' do
      it '画像が添付されていないと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameが空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'nameが40文字以上の場合登録できない' do
        a = 'a'
        a_41 = a * 41
        @item.name = a_41
        @item.valid?
        expect(@item.errors.full_messages).to include('Name is too long (maximum is 40 characters)')
      end
      it 'descriptionが空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'descriptionが1000文字以上の場合登録できない' do
        a = 'a'
        a_1001 = a * 1001
        @item.description = a_1001
        @item.valid?
        expect(@item.errors.full_messages).to include('Description is too long (maximum is 1000 characters)')
      end
      it 'category_idが1では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end
      it 'status_idが1では登録できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Status must be other than 1')
      end
      it 'burden_idが1では登録できない' do
        @item.burden_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Burden must be other than 1')
      end
      it 'prefecture_idが1では登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it 'day_to_ship_idが1では登録できない' do
        @item.day_to_ship_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Day to ship must be other than 1')
      end
      it 'priceが300より小さい場合登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it 'priceが9999999より大きい場合登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it 'user_idが紐づいていない場合登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
