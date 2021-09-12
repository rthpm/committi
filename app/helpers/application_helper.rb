module ApplicationHelper
  def liked?(status, user)
    Like.where(status: status, user: user).exists?
  end
end
