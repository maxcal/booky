class Ability
  include CanCan::Ability

  def initialize(user = User.new)
    alias_action :create, :read, :update, :destroy, :destroy_multiple, to: :crud

    can :crud, User, id: user.id

    can :crud, Authentication do |auth|
      auth.try(:user).try(:id) == user.id
    end

    if user.has_role?(:admin)
      can :manage, User
      can :manage, Authentication
    end
  end
end
