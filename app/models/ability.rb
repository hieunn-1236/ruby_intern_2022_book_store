class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    can :read, :all
    if user.admin?
      can :manage, :all
    else
      can %i(create read), Order
      can %i(read update), Order, user_id: user.id, status: :pending
    end
  end
end
