class PagesController < ApplicationController
  skip_before_filter :authenticate_user!

  def contact_us
  end
  def support
  end
  def dashboard
  end

  def make_redirect
    current_label
    if user_signed_in?
      if current_user.admin?
        redirect_to '/admin'
      elsif current_user.reseller?
        redirect_to '/resellers'
      else
        redirect_to '/businesses'
      end
    else
      redirect_to '/users/sign_in'
    end
  end

  def terms 
    render :terms, layout: "layouts/devise/sessions"
  end 

  def try_again_later
  end

  def resellers
    redirect_to admin_root_url
  end

  def congratulations

  end

  def begin_sync
    # the code to sync will come here ...
    render :layout=>nil
  end
end
