ActiveAdmin.register SiteProfile do
  menu if: proc { !current_user.reseller? }
  
end
