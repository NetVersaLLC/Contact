class Ability
  include CanCan::Ability

  def initialize(user)
    if user and user.admin?
      can :manage, :all
    elsif user
      can :manage, Business
      can :manage, Package
      can :manage, Subscription
    else
      can :manage, :all
    end
  end
end
