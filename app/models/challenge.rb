class Challenge < ApplicationRecord
  # Relationships
  belongs_to :user
  has_many :statuses, :dependent => :destroy
  has_many :enrollments, :dependent => :destroy

  # Validation rules
  validates :slug, :title,
            :uniqueness => true

  validates :title, :subtitle,
            :presence => true,
            :length => { :maximum => 100 }

  validates :description,
            :length => { :maximum => 100_000 }

  # Tasks assigning
  after_create :update_slug
  before_update :assign_slug

  def update_slug
    update :slug => assign_slug
  end

  def create_slug
    slug = self.title.parameterize
    if slug.empty?
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
