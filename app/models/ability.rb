class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.reseller?
      can :manage, Business
      can :manage, Coupon, :label_id => user.label_id
      can :manage, Label, :id => user.label_id
      can :manage, PackagesPayloads
      can :manage, Package
    else
      can :manage, :all
    end
  end
end
