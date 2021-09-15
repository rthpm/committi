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

  # Streaks hook
  after_create :increment_streaks

private

  def increment_streaks
    e = Enrollment.find_by(user: self.user, challenge: self.challenge)
    e.increment!(:streaks) unless e.nil? # To get the seed to work
  end
end
