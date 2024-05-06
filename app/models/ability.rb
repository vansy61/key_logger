# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, FbProfile, user: user
    return unless user.admin?
    can :manage, :all
  end
end
