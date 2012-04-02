class Job < ActiveRecord::Base
  def save_results(params, user)
    if self.user_id != user.id
      return false
    end

    return true
  end
end
