class Work < ApplicationRecord
  belongs_to :incident
  belongs_to :worker

  validates :date, presence: true
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0 }
end
