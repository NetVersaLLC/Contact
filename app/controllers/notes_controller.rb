class NotesController < ApplicationController
  respond_to :html, :json

  def new 
    @business = Business.find(params[:business_id])
    authorize! :read, @business
    authorize! :create, Note

    @note = Note.new
    @note.user_id = current_user.id
  end 

  def create 
    @business = Business.find(params[:business_id])
    authorize! :read, @business
    authorize! :create, Note

    @note = Note.new(params[:note])
    @note.user_id = current_user.id 
    @note.business_id = params[:business_id]
    @note.save

    flash[:notice] = "Note added successfully."
    respond_to do |format| 
      format.html { redirect_to customers_path }
      format.json { render :json => @hson } 
    end 
  end 

  def destroy 
    note = Note.find(params[:id]) 
    authorize! :destroy, note 

    note.delete 
    flash[:notice] = "Note removed." 
    redirect_to customers_url
  end 

end 
