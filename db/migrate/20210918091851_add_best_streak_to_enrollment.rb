class AddBestStreakToEnrollment < ActiveRecord::Migration[5.2]
  def change
    add_column :enrollments, :best_streak, :integer, :default => 0
  end
end
