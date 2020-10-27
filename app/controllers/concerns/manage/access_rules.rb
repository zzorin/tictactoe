module Manage::AccessRules
  def access_rules
    {
      # permissions: permissions_rules,
      # contests: contests_rules,
      # experts: experts_rules,
      # participants: participants_rules
      games: game_rules
    }
  end

  private

  def game_rules
    { manage: can?(:manage, Game) }
  end

  # def permissions_rules
  #   { manage: can?(:manage, Permission) }
  # end
  #
  # def contests_rules
  #   {
  #     manage: can?(:manage, Contest),
  #     index: can?(:index, Contest),
  #     new: can?(:new, Contest),
  #     update: can?(:update, Contest),
  #     destroy: can?(:destroy, Contest)
  #   }
  # end
  #
  # def experts_rules
  #   {
  #     manage: can?(:manage, Expert),
  #     index: can?(:index, Expert),
  #     new: can?(:new, Expert),
  #     destroy: can?(:destroy, Expert),
  #     index_for_results: can?(:for_results, Expert)
  #   }
  # end
  #
  # def participants_rules
  #   {
  #     manage: can?(:manage, Participant),
  #     new: can?(:new, Participant)
  #   }
  # end
end
