class Admin::DashboardController < Admin::ApplicationController
  def index
    @activities = ActivityLog::Activity.desc(:created_at).all
  end
end
