class Game::ApplicationController < ApplicationController
  protect_from_forgery with: :exception
  layout 'manage'

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to main_app.root_url, :alert => I18n.t("access_messages.forbidden") }
    end
  end
end
