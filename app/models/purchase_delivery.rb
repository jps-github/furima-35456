class PurchaseDelivery
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :token

  with_options presence: true do
    validates :token
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "は無効です。次のように入力してください。　例）123-4567"}
    validates :city
    validates :address
    validates :phone_number, numericality: { only_integer: true, message: "は無効です。数字のみ入力してください"}, length: { in: 10..11, message: "は10桁か11桁で入力してください" }
    validates :user_id
    validates :item_id
  end
  validates :prefecture_id, numericality: { other_than: 0, message: "を選択してください" }
  
  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Delivery.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end

end