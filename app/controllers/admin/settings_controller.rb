class Admin::SettingsController < Admin::ApplicationController
  respond_to :html

  def index
    @setting = Setting.first
  end

  def update
    @setting = Setting.first
    if @setting.update_attributes(params[:setting])
      flash[:notice] = t("notice.successfully.updated", :model => t("models.setting.name").capitalize)
    end
    respond_with([:admin,@setting], :location => admin_settings_url)
  end
end
