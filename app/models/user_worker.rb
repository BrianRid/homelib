class UserWorker < ApplicationRecord
  belongs_to :worker
  belongs_to :user
  validates :user, :worker
end
