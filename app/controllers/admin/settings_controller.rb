class Admin::SettingsController < Admin::ApplicationController
  respond_to :html

  def index
    @setting = Setting.first
  end

  def update
    @setting = Setting.first
    if @setting.update_attributes(params[:setting])
      flash[:notice] = t("notice.successfully.updated", :model => t("models.setting.name").capitalize)
      redirect_to admin_settings_url
    else
      render :action => :index
    end
  end
end
