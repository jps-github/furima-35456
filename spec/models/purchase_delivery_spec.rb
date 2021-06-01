require 'rails_helper'

RSpec.describe PurchaseDelivery, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_delivery = FactoryBot.build(:purchase_delivery, user_id: user.id, item_id: item.id)
    sleep 0.1 
  end

  def error_test(error_message)
    @purchase_delivery.valid?
    expect(@purchase_delivery.errors.full_messages).to include(error_message)
  end

  describe '商品購入機能' do

    context '購入できる場合' do
      it 'すべての項目が存在すれば購入できる' do
        expect(@purchase_delivery).to be_valid
      end

      it 'building_nameがなくても購入できる' do
        @purchase_delivery.building_name = ""
        expect(@purchase_delivery).to be_valid
      end
    end

    context '購入できない場合' do
      it 'tokenがないと購入できない' do
        @purchase_delivery.token = ""
        error_test("Token can't be blank")
      end

      it 'post_codeがないと購入できない' do
        @purchase_delivery.post_code = ""
        error_test("Post code can't be blank")
      end

      it 'post_codeに「-」がないと購入できない' do
        @purchase_delivery.post_code = "1234567"
        error_test("Post code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it 'post_codeの「-」の直前が半角数字３ケタでないと購入できない' do
        @purchase_delivery.post_code = "12-4567"
        error_test("Post code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it 'post_codeの「-」の直後が半角数字4ケタでないと購入できない' do
        @purchase_delivery.post_code = "123-456"
        error_test("Post code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it 'prefecture_idが0だと購入できない' do
        @purchase_delivery.prefecture_id = 0
        error_test("Prefecture can't be blank")
      end

      it 'cityがないと購入できない' do
        @purchase_delivery.city = ""
        error_test("City can't be blank")
      end
      
      it 'addressがないと購入できない' do
        @purchase_delivery.address = ""
        error_test("Address can't be blank")
      end

      it 'phone_numberがないと購入できない' do
        @purchase_delivery.phone_number = ""
        error_test("Phone number can't be blank")
      end

      it 'phone_numberが10ケタより少ないと購入できない' do
        @purchase_delivery.phone_number = "123456789"
        error_test("Phone number is too short")
      end

      it 'phone_numberが11ケタより多いと購入できない' do
        @purchase_delivery.phone_number = "123456789012"
        error_test("Phone number is too short")
      end

      it 'phone_numberに全角数字を入力すると購入できない' do
        @purchase_delivery.phone_number = "１２３４５６７８９０"
        error_test("Phone number is invalid. Input only number")
      end

      it 'phone_numberに文字列が含まれていると購入できない' do
        @purchase_delivery.phone_number = "12-3456-7890"
        error_test("Phone number is invalid. Input only number")
      end

      it 'user_idがないと購入できない' do
        @purchase_delivery.user_id = ''
        error_test("User can't be blank")
      end

      it 'item_idがないと購入できない' do
        @purchase_delivery.item_id = ''
        error_test("Item can't be blank")
      end

    end
    
  end

end
