class DownloadsController < ApplicationController
  def download
    @download = Download.new
    @download.user_id = current_user.id
    @download.key = current_user.authentication_token
    @download.make_setup
    @download.save
    send_file(@download.name,
              :type => "application/octet-stream",
              :disposition => "inline")
  end
end
