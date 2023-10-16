require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  describe '商品購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    context '内容に問題なく購入できる場合' do
      it 'すべての値が正しく入力されている' do
        expect(@order_shipping_address).to be_valid
      end
      it 'building_nameは空でも購入できる' do
        @order_shipping_address.building = ''
        expect(@order_shipping_address).to be_valid
      end
    end
      context '内容に問題があり購入できない場合' do
      it 'portal_codeが空である' do
        @order_shipping_address.portal_code = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Portal code can't be blank")
      end
      it 'portal_codeが半角のハイフンを含んだ正しい形式ではない' do
        @order_shipping_address.portal_code = '1234567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Portal code is invalid')
      end
      it 'portal_codeが半角の文字列ではない' do
        @order_shipping_address.portal_code = '１２３ー４５６７'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Portal code is invalid')
      end
    
      it 'prefectureが---を選択している' do
        @order_shipping_address.prefecture_id = '1'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空である' do
        @order_shipping_address.city = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空である' do
        @order_shipping_address.address = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Address can't be blank")
      end
      it 'phoneが空である' do
        @order_shipping_address.phone = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone can't be blank")
      end
      it 'phoneが10桁未満である' do
        @order_shipping_address.phone = '000000000'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Phone is invalid')
      end
      it 'phoneが12桁以上である' do
        @order_shipping_address.phone = '000000000000'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Phone is invalid')
      end
      it 'phoneが半角の文字列ではない' do
        @order_shipping_address.phone = '０９０００００００００'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Phone is invalid')
      end
      it 'クレジットカードの情報が空である' do
        @order_shipping_address.token = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'ユーザー情報が紐づいていないと出品できない' do
        @order_shipping_address.user_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("User can't be blank")
      end
      it '商品情報が紐づいていないと出品できない' do
        @order_shipping_address.item_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end