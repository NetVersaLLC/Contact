class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.reseller?
      can :manage, Business, :user => { :label_id => user.label_id }
      can :manage, Coupon, :label_id => user.label_id
      can [:read, :update], Label, :id => user.label_id
      can :read,   Location
      can :manage, PackagePayload, :package => { :label_id => user.label_id }
      can :manage, Package, :label_id => user.label_id
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
      can :manage, Job
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
      can :manage, Subscription, :business => { :user_id => user.id }
      can :create, Booboo, :user_id => user.id
      can :manage, Job, :business => { :user_id => user.id }
      can :manage, [CompletedJob, FailedJob], :business => { :user_id => user.id }
      can :manage, Account, :business => { :user_id => user.id }
      can :read,   Coupon
      can :read,   Label
      can :read,   Location
      can :read,   Package
      can :read,   PackagePayload
      can :manage, Notification, :business => { :user_id => user.id }
      can :manage, Download
      can :manage, Task, :business => { :user_id => user.id }
    end
  end
end
