module ApplicationHelper
  def liked?(status, user)
    Like.where(status: status, user: user).exists?
  end
  
  def enrolled?(challenge, user)
    Enrollment.where(challenge: challenge, user: user).exists?
  end
end
