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
        error_test("クレジットカード情報を入力してください")
      end

      it 'post_codeがないと購入できない' do
        @purchase_delivery.post_code = ""
        error_test("郵便番号を入力してください")
      end

      it 'post_codeに「-」がないと購入できない' do
        @purchase_delivery.post_code = "1234567"
        error_test("郵便番号は無効です。次のように入力してください。　例）123-4567")
      end

      it 'post_codeの「-」の直前が半角数字３ケタでないと購入できない' do
        @purchase_delivery.post_code = "12-4567"
        error_test("郵便番号は無効です。次のように入力してください。　例）123-4567")
      end

      it 'post_codeの「-」の直後が半角数字4ケタでないと購入できない' do
        @purchase_delivery.post_code = "123-456"
        error_test("郵便番号は無効です。次のように入力してください。　例）123-4567")
      end

      it 'prefecture_idが0だと購入できない' do
        @purchase_delivery.prefecture_id = 0
        error_test("都道府県を選択してください")
      end

      it 'cityがないと購入できない' do
        @purchase_delivery.city = ""
        error_test("市区町村を入力してください")
      end
      
      it 'addressがないと購入できない' do
        @purchase_delivery.address = ""
        error_test("丁目・番地・号を入力してください")
      end

      it 'phone_numberがないと購入できない' do
        @purchase_delivery.phone_number = ""
        error_test("電話番号を入力してください")
      end

      it 'phone_numberが10ケタより少ないと購入できない' do
        @purchase_delivery.phone_number = "123456789"
        error_test("電話番号は10桁か11桁で入力してください")
      end

      it 'phone_numberが11ケタより多いと購入できない' do
        @purchase_delivery.phone_number = "123456789012"
        error_test("電話番号は10桁か11桁で入力してください")
      end

      it 'phone_numberに全角数字を入力すると購入できない' do
        @purchase_delivery.phone_number = "１２３４５６７８９０"
        error_test("電話番号は無効です。数字のみ入力してください")
      end

      it 'phone_numberに文字列が含まれていると購入できない' do
        @purchase_delivery.phone_number = "12-3456-7890"
        error_test("電話番号は無効です。数字のみ入力してください")
      end

      it 'user_idがないと購入できない' do
        @purchase_delivery.user_id = ''
        error_test("購入する会員を入力してください")
      end

      it 'item_idがないと購入できない' do
        @purchase_delivery.item_id = ''
        error_test("購入する商品を入力してください")
      end

    end
    
  end

end
