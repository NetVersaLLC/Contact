ActiveAdmin.register Subscription do
  menu parent: "users"
  actions :all, :except => [:new]
  
end
