class Comment < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :status

  # Validation rules
  validates :content,
            :presence => true,
            :length => { maximum: 100_000 }
end
