desc "This task is called by a cronjob or any schedulder to reset a streak counter if applicable"
task :reset_streaks => :environment do
  Enrollment.find_each do |enrollment|
    user = enrollment.user
    status = user.statuses.last
    streaks = enrollment.streaks
    challenge = enrollment.challenge
    interval = challenge.interval
    next_date = challenge.next_date

    # Dailies
    if interval == "daily" && (status.created_at.utc.to_date < Time.now.utc.to_date) 
      streaks = 0
    end
    if interval == "weekly" && (next_date - status.created_at.utc.to_date).to_i > 7 
      streaks = 0
    end
    if interval == "monthly" && (next_date - status.created_at.utc.to_date).to_i > 30 
      streaks = 0
    end
    enrollment.save
  end
end
