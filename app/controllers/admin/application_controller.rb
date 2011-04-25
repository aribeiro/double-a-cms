# -*- encoding : utf-8 -*-
class Admin::ApplicationController < ApplicationController
  layout "admin"
  before_filter :authenticate_user!
  before_filter :set_locale
  before_filter :current_activity, :only => [:create, :update, :destroy]

  protected
  def set_locale
    I18n.locale = Setting.first.admin_locale.to_sym if Setting.first
  end

  def current_activity
    ActivityLog::Activity.current_user = current_user
  end
  
end
