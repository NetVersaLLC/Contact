class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :manage, Business,     :label_id => user.label_id
      can :manage, Package,      :label_id => user.label_id
      can :manage, Subscription, :label_id => user.label_id
    end
  end
end
