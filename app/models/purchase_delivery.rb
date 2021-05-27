class PurchaseDelivery
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :address, :building_name, :phone_number

  with_options presence: true do
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"}
    validates :city
    validates :address
    validates :phone_number, numericality: { only_integer: true, message: "is invalid. Input only number"}, length: { in: 10..11, message: "is too short" }
    validates :user_id
    validates :item_id
  end
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
  
  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Delivery.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end

end