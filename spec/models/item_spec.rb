require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  def error_test(error_message)
    @item.valid?
    expect(@item.errors.full_messages).to include(error_message)
  end

  describe '商品出品機能' do
    context '出品できる場合' do
      it 'すべての項目が存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できない場合' do
      it 'imageが添付されなければ登録できない' do
        @item.images = nil
        error_test("画像を入力してください")
      end

      it 'nameが未記入であれば登録できない' do
        @item.name = ''
        error_test("商品名を入力してください")
      end

      it 'descriptionが未記入であれば登録できない' do
        @item.description = ''
        error_test("商品説明を入力してください")
      end

      it 'categoryが未選択であれば登録できない' do
        @item.category_id = 0
        error_test("カテゴリーを選択してください")
      end

      it 'conditionが未選択であれば登録できない' do
        @item.condition_id = 0
        error_test("商品状態を選択してください")
      end

      it 'delivery_chargeが未選択であれば登録できない' do
        @item.delivery_charge_id = 0
        error_test("送料負担を選択してください")
      end

      it 'prefectureが未選択であれば登録できない' do
        @item.prefecture_id = 0
        error_test("発送元を選択してください")
      end

      it 'delivery_dayが未選択であれば登録できない' do
        @item.delivery_day_id = 0
        error_test("発送日数を選択してください")
      end

      it 'priceが未記入であれば登録できない' do
        @item.price = ''
        error_test("価格を入力してください")
      end

      it 'priceが¥299以下であれば登録できない' do
        @item.price = 100
        error_test('価格は300円〜9,999,999円の範囲で入力してください')
      end

      it 'priceが¥10,000,000以上であれば登録できない  ' do
        @item.price = 100_000_000
        error_test('価格は300円〜9,999,999円の範囲で入力してください')
      end

      it 'priceが半角数字でなければ登録できない' do
        @item.price = '３００'
        error_test('価格は無効です。半角数字で入力してください')
      end

      it 'priceが半角英数混合であれば登録できない' do
        @item.price = '123abc'
        error_test('価格は無効です。半角数字で入力してください')
      end

      it 'priceが半角英語だけでは登録できない' do
        @item.price = 'abc'
        error_test('価格は無効です。半角数字で入力してください')
      end
    end
  end
end
