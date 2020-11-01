module Manage::AccessRules
  def access_rules
    {
      games: game_rules
    }
  end

  private

  def game_rules
    { manage: can?(:manage, Game) }
  end
end
