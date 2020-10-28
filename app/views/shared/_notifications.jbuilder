json.notifications do
  json.title I18n.t("notifications.model_names.#{model}") +': '+ I18n.t("notifications.#{action_name}.title")
  json.text I18n.t("notifications.model_names.#{model}") +' - '+ I18n.t("notifications.#{action_name}.text")
end
