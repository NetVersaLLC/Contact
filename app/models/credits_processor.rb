# 
# There is this concept of credits in the application.  These credits 
# are purchased with a credit card and then applied to the appropriate 
# business object.  These credits can then be transferred to other objects, 
# and deducted as payments for using the system. 
#
# Each time there is an event, it is logged so the credit holder can view 
# a history of their credits used throughout the system  
#
# This class will process credits on any business object that responds to 
# the credits message.  As of May 2013, only the Label holds credits.  
class CreditsProcessor 

  def initialize( actor, holder ) 
    @actor = actor 
    @holder = holder 
  end 

  # quantity, notes 
  def add( params ) 
    q = params[:quantity].to_i
    n = params[:note] 
    ActiveRecord::Base.transaction do 

      CreditEvent.create( quantity: q, user_id: @actor.id, action: :add, label_id: @holder.id, note: n) 

      @holder.reload(:lock => true ) 
      @holder.update_attribute( :credits, @holder.credits + q) 
    end 
  end 

  # quantity, receivor id, notes 
  def transfer( receivor, params ) 
    q = params[:quantity].to_i
    n = params[:note] 
    ActiveRecord::Base.transaction do 

      CreditEvent.create( quantity: -q, 
                         user_id: @actor.id, 
                         action: :payment_to, 
                         label_id: @holder.id, 
                         other_id: receivor.id, 
                         note: n ) 

      CreditEvent.create( quantity: q, 
                         user_id: @actor.id, 
                         action: :payment_from, 
                         label_id: receivor.id, 
                         other_id: @holder.id, 
                         note: n ) 

      @holder.reload(:lock => true ) 
      @holder.update_attribute( :credits, @holder.credits - q) 
      receivor.reload(:lock => true ) 
      receivor.update_attribute( :credits, receivor.credits + q) 
    end 
  end 

  # quantity, notes 
  def pay( params ) 
    q = -(params[:quantity].to_i)
    n = params[:note] 
    ActiveRecord::Base.transaction do 

      CreditEvent.create( quantity: q, user_id: @actor.id, action: :pay, label_id: @holder.id, note: n ) 

      @holder.reload(:lock => true ) 
      @holder.update_attribute( :credits, @holder.credits + q) 
    end 
  end 
end 
