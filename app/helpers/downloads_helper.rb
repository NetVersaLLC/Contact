module DownloadsHelper 

  def download_client_url
    env = Rails.env

    if browser.ie?
      "https://secureinstall.us/#{env}/#{current_label.name}/#{current_label.name}.application"
    else 
      "https://secureinstall.us/#{env}/#{current_label.name}/setup.exe"
    end 
  end 


end 
