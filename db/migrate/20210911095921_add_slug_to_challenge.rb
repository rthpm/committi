class AddSlugToChallenge < ActiveRecord::Migration[5.2]
  def change
    add_column :challenges, :slug, :string
  end
end
