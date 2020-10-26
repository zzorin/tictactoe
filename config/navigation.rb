SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |primary|
    primary.item :main_page, 'Главная', root_path

    if current_user
      primary.item :administrator, t('permissions.administrator'), root_path#administrator_root_path if current_user.administrator?
      primary.item :participant, t('permissions.participant'), root_path#participant_root_path if current_user.participant?
      primary.item :participant, t('permissions.participant'), destroy_user_session_path
    end
  end
end

# SimpleNavigation.register_renderer first_renderer:       FirstRenderer
# SimpleNavigation.register_renderer second_renderer:      SecondRenderer
# SimpleNavigation.register_renderer mobile_menu_renderer: MobileMenuRenderer
