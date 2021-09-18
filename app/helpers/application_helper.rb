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
    status.order(created_at: :desc).first.created_at.to_date != Time.now.to_date
  end

  def has_rights?(user = nil)
    return false unless user_signed_in?
    return true if current_user.is_admin || current_user == @user || current_user == user
  end
end
