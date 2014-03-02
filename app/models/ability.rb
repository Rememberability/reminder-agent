class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, Item, user_id: user.id
  end
end
