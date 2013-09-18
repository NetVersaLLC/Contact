class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.reseller?
      # Deny access https://www.pivotaltracker.com/story/show/53672601
      # Used with the ActiveAdmin CanCan adapter.  
      #can :manage, PackagePayload, :package => { :label_id => user.label_id }
      #can :manage, Package, :label_id => user.label_id
      #can :manage, Job, :business => { :label_id => user.label_id }
      #can :manage, CompletedJob, :business => { :label_id => user.label_id }
      #can :manage, FailedJob, :business => { :label_id => user.label_id }

      can :read,   ActiveAdmin::Page, :name => "Dashboard"
      can :read,   ActiveAdmin::Page, :name => "My Label"
      can :read,   Report, :label_id => user.label_id
      can :manage, Business, :user => { :label_id => user.label_id }
      can :manage, Coupon, :label_id => user.label_id
      can :read,   CreditEvent, :label_id => user.label_id 
      can :manage, Label, :id => user.label_id
      can :manage, Label, :parent_id => user.label_id
      can :read,   Location
      can :manage, Payment, :label_id => user.label_id
      can :manage, User, :label_id => user.label_id
      can :manage, [Subscription,TransactionEvent,Payment], :label_id => user.label_id

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
    else
      can :manage, Business, :user_id => user.id
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
      can :read,   SiteProfile 
      can :manage, [Subscription,TransactionEvent,Payment], :business => { :user_id => user.id }
      can :create, Booboo, :user_id => user.id
      can :manage, Job, :business => { :user_id => user.id }
      can :manage, CompletedJob, :business => { :user_id => user.id }
      can :manage, FailedJob, :business => { :user_id => user.id }
      can :manage, [CompletedJob, FailedJob], :business => { :user_id => user.id }
      can :manage, Code, :business => { :user_id => user.id }
      can :manage, Account, :business => { :user_id => user.id }
      can :read,   Coupon
      can [:read,:update], Label, :id => user.label_id
      can :read,   Location
      can :read,   Package
      can :read,   PackagePayload
      can :manage, Notification, :business => { :user_id => user.id }
      can :manage, Download
      can :manage, Task, :business => { :user_id => user.id }
    end
  end
end
