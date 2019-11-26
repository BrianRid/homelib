class User < ApplicationRecord
  has_one_attached :avatar
  has_many :user_workers

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def initial
    "#{first_name.first.capitalize}#{last_name.first.capitalize}"
  end
end
