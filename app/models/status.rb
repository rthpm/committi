class Status < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :challenge
  has_many :likes,
           :dependent => :delete_all

  # Validation rules
  validates :content,
            :presence => true,
            :length => { maximum: 100_000 }
end
