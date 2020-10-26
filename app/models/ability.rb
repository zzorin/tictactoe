# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    raise user.inspect
  end
end
