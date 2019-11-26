class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :flat
  has_many :rents

  validates :start_date, presence: true
  validates :start_date_after_today?
  validates :rental_period_is_free?
end
