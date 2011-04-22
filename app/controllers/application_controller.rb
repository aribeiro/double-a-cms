class ApplicationController < ActionController::Base
  protect_from_forgery

  def website_settings
    setting ||= Setting.first
    setting
  end
  helper_method :website_settings
end
