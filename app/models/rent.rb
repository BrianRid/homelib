class Rent < ApplicationRecord
  belongs_to :rental
  has_one :flat, through: :rental
end
