class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is_a? Administrator
      can :manage, :all
    elsif user.is_a? Reseller
      can :create, [Manager, SalesPerson]
      can :read,   Report, :label_id => user.label_id
      can :manage, Business, :user => { :label_id => user.label_id }
      can :manage, ClientData, :business => {:label_id => user.label_id}
      can :manage, Coupon, :label_id => user.label_id
      can :manage, CallCenter, :label_id => user.label_id
      can :read,   CreditEvent, :label_id => user.label_id 
      can :manage, Label, :id => user.label_id
      can :manage, Label, :parent_id => user.label_id
      can :manage, Notification, :business => { :label_id => user.label_id } 
      can :manage, Package, :label_id => user.label_id
      can :manage, SiteCategory
      can :read,   Question
      can :read,   Location
      can :manage, Payment, :label_id => user.label_id
      can :manage, User, :label_id => user.label_id
      can :manage, [Subscription,TransactionEvent,Payment], :label_id => user.label_id
      can :manage,  [Job, CompletedJob, FailedJob], :label_id => user.label_id
      cannot :manage, [Administrator, Reseller]
      can :read, Reseller, :label_id => user.label_id
      can :manage, Note, :business => { :label_id => user.label_id }

      Business.citation_list.each do |site|
        can :manage, site[0].constantize, :business => { :label_id => user.label_id }
      end
      Business.citation_list.each do |site|
        site[2].each do |row|
          if row[0] == 'select'
            can :read, row[1].classify.constantize, :business => { :user_id => user.id }
          end
        end
      end
    elsif user.is_a? Manager
      can :manage, SalesPerson, :manager_id => user.id
      can :manage, CustomerServiceAgent, :call_center_id => user.call_center_id
      can :read, Manager, :id => user.id
      can [:create, :update, :read], User, :manager_id => user.id
      can :manage, Business, :call_center_id => user.call_center_id
      can :manage, Note, :business => { :call_center_id => user.call_center_id}
      can :manage, User, :call_center_id => user.call_center_id #:businesses => {:sales_person => { :manager_id => user.id}}
      can :manage, Subscription, :business => {:sales_person => { :manager_id => user.id}}
      can :manage, ClientData, :business => {:call_center_id => user.call_center_id}
      can :read, CallCenter, :id => user.call_center_id
      #can :read,   Report, :label_id => user.label_id
    elsif user.is_a? SalesPerson
      can :manage, Business, :sales_person_id => user.id
      can :manage, Note, :business => { :sales_person_id => user.id }
      can [:create, :read, :update], User, :businesses => { :sales_person_id => user.id } 
    elsif user.is_a? CustomerServiceAgent
      can :manage, Business,     :call_center_id => user.call_center_id
      can :manage, Note,         :business => { :call_center_id => user.call_center_id}
      can :manage, ClientData,   :business => {:call_center_id => user.call_center_id}
      can :manage, Notification, :business => { :call_center_id => user.call_center_id } 
      can :manage, Subscription, :label_id => user.label_id
      can :manage, User,         :label_id => user.label_id
    else
      can [:update, :read], Business, :user_id => user.id
      Business.citation_list.each do |site|
        can :manage, site[0].constantize, :business => { :user_id => user.id }
      end
      Business.citation_list.each do |site|
        site[2].each do |row|
          if row[0] == 'select'
            can :read, row[1].classify.constantize, :business => { :user_id => user.id }
          end
        end
      end
      can :read,            ClientData, :business => { :user_id => user.id }
      can :read,            Subscription, :business => { :user_id => user.id }
      can :manage,          [TransactionEvent,Payment], :business => { :user_id => user.id }
      can :create,          Booboo, :user_id => user.id
      can [:read, :update], Job, :business => { :user_id => user.id }
      can :manage,          Code, :business => { :user_id => user.id }
      can :manage,          Account, :business => { :user_id => user.id }
      can :read,            Coupon
      can [:read, :update], Label, :id => user.label_id
      can :read,            [Location, Package, Question]
      can :read,            PackagePayload
      can :manage,          Notification, :business => { :user_id => user.id }
      can :manage,          Download
      can :manage,          Task, :business => { :user_id => user.id }
      can :manage,          Report, :business_id => user.businesses.pluck(:id)
      can [:read, :update], User, :id => user.id
    end
  end
end
