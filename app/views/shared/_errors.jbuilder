json.status :error
if item.errors.any?
  json.errors do
    json.messages item.errors
    json.title I18n.t("notifications.model_names.#{model}") +': '+ I18n.t("notifications.#{action_name}.errors.title")
    json.text item.errors.values.join('<br >')
  end
end
