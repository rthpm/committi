desc "This task is called by a cronjob or any schedulder to reset a streak counter if applicable"
task :reset_streaks => :environment do
  Enrollment.find_each do |enrollment|
    user = enrollment.user
    status = user.statuses.last
    streaks = enrollment.streaks

    # Dailies
    if status.created_at.utc.to_date < Time.now.utc.to_date
      streaks = 0
    end
    enrollment.save
  end
end
