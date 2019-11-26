class Flat < ApplicationRecord
  belongs_to :user
  has_many :incidents
  has_many :rentals

  validates :address, presence: true, uniqueness: true
  validates :nb_rooms :area :furnished :syndic_name :syndic_phone :syndic_email, presence: true
end
