class Incident < ApplicationRecord
  belongs_to :flat
  has_many :incidents
end
