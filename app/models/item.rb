class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :delivery_day

  belongs_to :user
  has_many_attached :images
  has_one :purchase

  with_options numericality: { other_than: 0, message: "を選択してください" } do
    validates :category_id
    validates :condition_id
    validates :delivery_charge_id
    validates :delivery_day_id
    validates :prefecture_id
  end

  with_options presence: true do
    validates :images
    validates :name
    validates :description
    validates :price
  end
  validates :price, inclusion: { in: 300..9_999_999, message: 'は300円〜9,999,999円の範囲で入力してください' }
  validates :price, numericality: { message: 'は無効です。半角数字で入力してください' }
end
