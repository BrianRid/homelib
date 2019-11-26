class Worker < ApplicationRecord
  has_many :workers
  has_many :works

  validates :name, presence: true, uniqueness: true
  validates :phone, :description, presence: true
  validates :categories, inclusion: { in:["plomberie", "électricité", "serrurerie", "chauffage", "vitrerie", "petits travaux", "jardinage", "peinture", "sols", "électroménager"]}
  validates :email, presence: true, format: Devise.email_regexp
end
