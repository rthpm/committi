class Category < ApplicationRecord
  # Relationships
  has_many :challenges

  # Validation rules
  # TODO(@romain): If the need arises, we should create proper categories
  # validation. For now, categories are manually created by the admins from the
  # console, there’s no User interaction with them for now.
  # Meanwhile, you can generate basic categories from lib/tasks/create_categories.rb
  # Adjust the script for your needs.

  # Slug assigning
  # TODO(@romain): See the comment above.
end
