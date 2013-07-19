ActiveAdmin.register SiteProfile do
  menu if: proc { !current_user.is_reseller? }
  
end
