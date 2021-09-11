class Like < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :status

  def self.total_like(status)
    Like.where(status: status).count
  end
end
