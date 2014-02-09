Warden::Manager.after_authentication do |user,auth,opts|
  user.update_attribute(:last_user_agent, auth.request.user_agent)
end
