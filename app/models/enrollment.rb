class Enrollment < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :challenge
end
