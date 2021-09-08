class CreateChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :challenges do |t|
      t.string :title,        null: false, default: "", limit: 300
      t.string :subtitle,     default: "", limit: 300
      t.text :description,    default: "", limit: 1200
      t.belongs_to :user

      t.timestamps
    end
  end
end
