class AddIntervalToChallenge < ActiveRecord::Migration[5.2]
  def change
    add_column :challenges, :interval, :string
    add_column :challenges, :next_date, :date
  end
end
