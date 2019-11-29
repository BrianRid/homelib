class Document < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  validates :name, presence: true

end
