class Status < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :challenge
  has_many :likes, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  # Validation rules
  validates :content,
            :presence => true,
            :length => { maximum: 100_000 }
end
