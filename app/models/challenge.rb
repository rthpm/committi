class Challenge < ApplicationRecord
  # Relationships
  belongs_to :user
  has_many :statuses, :dependent => :destroy

  # Validation rules
  validates :slug, :title,
            :uniqueness => true

  validates :title, :subtitle,
            :length => { :maximum => 100 }

  validates :title,
            :presence => true

  # Tasks assigning
  after_create :update_slug
  before_update :assign_slug

  def update_slug
    update :slug => assign_slug
  end

  def create_slug
    self.title.parameterize
  end

private

  def assign_slug
    self.slug = create_slug
  end
end
