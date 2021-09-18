class Challenge < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :category
  has_many :statuses, :dependent => :destroy
  has_many :enrollments, :dependent => :destroy

  # Validation rules
  validates :title,
            :length => { :minimum => 5, :maximum => 50 }

  validates :slug, :title,
            :uniqueness => true

  validates :title, :subtitle,
            :presence => true,
            :length => { :maximum => 50 }

  validates :description,
            :length => { :maximum => 100_000 }

  VALID_INTERVAL = ["daily", "weekly", "monthly"].freeze
  TIME_REQUIRED = ["weekly", "monthly"].freeze
  TIMELY_FREE = ["daily"].freeze

  validates_each :interval do |record, attr, value|
    unless VALID_INTERVAL.include?(value.to_s.downcase)
      record.errors.add(attr, "is not permitted")
    end
  end

  validates :next_date, presence: { :if => lambda { TIME_REQUIRED.include?(self.interval) } }
  validates :next_date, absence: { :if => lambda { TIMELY_FREE.include?(self.interval) } }

  # Slug assigning
  after_create :update_slug
  before_update :assign_slug

  def update_slug
    update :slug => assign_slug
  end

  def create_slug
    slug = self.title.parameterize
    if slug.empty? || slug.length < self.title.length
      self.id
    else
      slug
    end
  end

private

  def assign_slug
    self.slug = create_slug
  end
end
