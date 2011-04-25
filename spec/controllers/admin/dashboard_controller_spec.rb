require 'spec_helper'

describe Admin::DashboardController do
  login_user
  
  def mock_activity(stubs={})
    @mock_activity ||= mock_model(ActivityLog::Activity, stubs).as_null_object
  end
  
  describe "GET 'index'" do
    it "be successful" do
      get :index
      response.should be_success
    end

    it "assings all ActivityLog Activities as @activities" do
      ActivityLog::Activity.stub_chain(:desc, :all) {[mock_activity]}
      get :index
      assigns(:activities).should == [mock_activity]
    end
  end

end
