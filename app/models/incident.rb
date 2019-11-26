class Incident < ApplicationRecord
  belongs_to :flat
  has_many :works
  validates :dispo, presence: true
  validates :category, presence: true, inclusion: { in: ["plomberie", "électricité", "serrurerie", "chauffage", "vitrerie", "petits travaux", "jardinage", "peinture", "sols", "électroménager"]}
end
