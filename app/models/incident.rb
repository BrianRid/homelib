class Incident < ApplicationRecord
  belongs_to :flat
  has_many :incidents

  validates :dispo, presence: true
  validates :types, presence: true, inclusion: { in: ["plomberie", "électricité", "serrurerie", "chauffage", "vitrerie", "petits travaux", "jardinage", "peinture", "sols", "électroménager"]}
end
