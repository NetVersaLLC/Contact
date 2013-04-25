ActiveAdmin.register_page "Credits" do 
  menu false 

  page_action :transfer, :method => :post do 
    #stuff here 
    #redirect_to 
  end 

  action_item do 
    link_to "do stuff", new_user_session_path 
  end 

  content do 
    panel "Transfer" do 
      render partial: "credit_transfer" # locals: { post: post }  
      

      #child = Label.find(params[:label_id]) 
      form(:action => '/admin/credits/transfer', :method => 'post') do |f|
        form_authenticity_token
        f.input :hello
      end 
    end 
  end 

end 
