class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :flat
  has_many :rents

  validates :start_date, presence: true
  # validates :start_date_after_today?
  # validates :rental_period_is_free?


private

  def start_date_after_today?
    return if start_date.blank?
    errors.add(:start_date, "must be equal or after today") if start_date < Date.today
  end
end
