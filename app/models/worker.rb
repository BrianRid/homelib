class Worker < ApplicationRecord
<<<<<<< HEAD
  has_many :workers
  has_many :works
=======
  has_many :user_workers
>>>>>>> 909b213a7637a156643db1d9d9cb1dc609cf988a

  validates :name, presence: true, uniqueness: true
  validates :phone, :description, presence: true
  validates :categories, inclusion: { in:["plomberie", "électricité", "serrurerie", "chauffage", "vitrerie", "petits travaux", "jardinage", "peinture", "sols", "électroménager"]}
  validates :email, presence: true, format: Devise.email_regexp
end
