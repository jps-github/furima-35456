class Prefecture < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :PrefectureGenre

  validates :title, :text, presence: true
  validates :genre_id, numericality: { other_than: 0 } 
end
