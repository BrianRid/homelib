class Worker < ApplicationRecord
  has_many :works
  has_many :user_workers

  validates :name, presence: true, uniqueness: true
  validates :phone, :description, presence: true
  validates :categories, inclusion: { in: ["plomberie", "électricité", "serrurerie", "chauffage", "vitrerie", "petits travaux", "jardinage", "peinture", "sols", "électroménager"]}
  validates :email, presence: true, format: Devise.email_regexp
end
