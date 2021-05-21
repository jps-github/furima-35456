class DeliveryDay < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :DeliveryDayGenre

  validates :title, :text, presence: true
  validates :genre_id, numericality: { other_than: 0 } 
end
