desc "This task is called by a cronjob or any schedulder to reset a streak counter if applicable"
task :reset_streaks => :environment do
  Enrollment.find_each do |enrollment|
    user = enrollment.user
    status = user.statuses.last
    if status.created_at.utc.to_date < Time.now.utc.to_date
      enrollment.streaks = 0
      enrollment.save
    end
  end
end
