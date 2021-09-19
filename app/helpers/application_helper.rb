module ApplicationHelper
  def liked?(status, user)
    Like.where(status: status, user: user).exists?
  end
  
  def enrolled?(challenge, user)
    Enrollment.where(challenge: challenge, user: user).exists?
  end

  def can_post?(challenge, user)
    status = Status.where(user: user, challenge: challenge)
    return true unless status.exists?
    return true if challenge.interval == "daily" && Time.now.utc.to_date != status.last.created_at.utc.to_date
    return true if challenge.interval == "weekly" && (challenge.next_date - status.last.created_at.utc.to_date).to_i > 7
    return true if challenge.interval == "monthly" && (challenge.next_date - status.last.created_at.utc.to_date).to_i > 30
  end

  def has_rights?(user = nil)
    return false unless user_signed_in?
    return true if current_user.is_admin || current_user == @user || current_user == user
  end

  def premiumize_user
    current_user.is_premium = true
    current_user.save
  end
end
