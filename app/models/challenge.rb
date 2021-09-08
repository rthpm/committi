class Challenge < ApplicationRecord
  # Relationships
  belongs_to :user

  # Validation rules
  validates :title, :subtitle,
            :length => { :maximum => 100 }

  validates :title,
            :presence => true
end
