desc "This task change the next date of a challenge if the interval is over"
task :advance_challenge_date => :environment do
  Challenge.find_each do |challenge|
    if challenge.interval == "weekly" && (challenge.next_date - Time.now.utc.to_date).to_i == 0
      challenge.next_date += 7
    end
    if challenge.interval == "monthly" && (challenge.next_date - Time.now.utc.to_date).to_i == 0
      challenge.next_date += 30
    end
    challenge.save
  end
end
