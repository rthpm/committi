class CreateStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :statuses do |t|
      t.text :content, null: false, default: ""
      t.belongs_to :user, index: true
      t.belongs_to :challenge, index: true

      t.timestamps
    end
  end
end
