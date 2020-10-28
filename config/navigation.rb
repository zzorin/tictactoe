SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |primary|

    if current_user
      primary.item :main_page, 'Главная', player_menu_root_path
      # primary.item :administrator, t('permissions.game'), player_root_path#administrator_root_path if current_user.administrator?
      primary.item :participant, t('permissions.sign_out'), destroy_user_session_path
    end
  end
end
