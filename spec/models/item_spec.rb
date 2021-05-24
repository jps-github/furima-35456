require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  def error_test(error_message)
    @item.valid?
    expect(@item.errors.full_messages).to include(error_message)
  end

  describe "商品出品機能" do

    context '出品できる場合' do

      it "すべての項目が存在すれば登録できる" do
        expect(@item).to be_valid
      end

    end

    context '出品できない場合' do

      it "imageが添付されなければ登録できない" do
        @item.image = nil
        error_test("Image can't be blank")
      end

      it "nameが未記入であれば登録できない" do
        @item.name = ""
        error_test("Name can't be blank")
      end

      it "descriptionが未記入であれば登録できない" do
        @item.description = ""
        error_test("Description can't be blank")
      end

      it "categoryが未選択であれば登録できない" do
        @item.category_id = 0
        error_test("Category can't be blank")
      end

      it "conditionが未選択であれば登録できない" do
        @item.condition_id = 0
        error_test("Condition can't be blank")
      end

      it "delivery_chargeが未選択であれば登録できない" do
        @item.delivery_charge_id = 0
        error_test("Delivery charge can't be blank")
      end

      it "prefectureが未選択であれば登録できない" do
        @item.prefecture_id = 0
        error_test("Prefecture can't be blank")
      end

      it "delivery_dayが未選択であれば登録できない" do
        @item.delivery_day_id = 0
        error_test("Delivery day can't be blank")
      end

      it "priceが未記入であれば登録できない" do
        @item.price = ""
        error_test("Price can't be blank")
      end

      it "priceが範囲（¥300-¥9,999,999）の外であれば登録できない" do
        @item.price = 100
        error_test("Price is out of setting range")
      end

      it "priceが半角数字でなければ登録できない" do
        @item.price = "３００"
        error_test("Price is invalid. Input half-width characters")
      end

    end

  end

end
