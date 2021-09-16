class AddCategoryToChallenges < ActiveRecord::Migration[5.2]
  def change
    add_reference :challenges, :category, foreign_key: true
  end
end
