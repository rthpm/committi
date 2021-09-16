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

  def has_rights?
    return true if current_user.is_admin
    if current_user != @status.user
      redirect_back fallback_location: root_path,
                    alert: 'Vous ne pouvez pas faire cela'
    end
  end
end
