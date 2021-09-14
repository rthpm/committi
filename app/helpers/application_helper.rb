module ApplicationHelper
  def liked?(status, user)
    Like.where(status: status, user: user).exists?
  end
  
  def enrolled?(challenge, user)
    Enrollment.where(challenge: challenge, user: user).exists?
  end

  def can_post?(challenge, user)
    status = Status.where(user: user, 
                          challenge: challenge).order(created_at: :desc).first.created_at.to_date
    status != Time.now.to_date
  end
end
