class QuestionsController < InheritedResources::Base
  load_and_authorize_resource 

  respond_to :html, :json
  actions :all

  add_breadcrumb 'FAQs', :accounts_url
  add_breadcrumb 'Edit Question', nil, only: [:edit, :update]

end 
