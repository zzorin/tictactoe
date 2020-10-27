# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if true
        can :manage, :all
      end
    end

  end
end
