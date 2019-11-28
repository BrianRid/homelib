class Flat < ApplicationRecord
  has_many_attached :photos
  belongs_to :user
  has_many :incidents
  has_many :rentals

  validates :address, :nb_rooms, :area, :syndic_name, :syndic_phone, :syndic_email, presence: true
end
