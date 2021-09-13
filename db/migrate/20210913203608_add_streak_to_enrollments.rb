class AddStreakToEnrollments < ActiveRecord::Migration[5.2]
  def change
    add_column :enrollments, :streaks, :integer, :default => 0
  end
end
