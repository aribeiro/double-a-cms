require 'spec_helper'

describe Admin::SettingsController do
  login_user
  
  def mock_setting(stubs={})
    @mock_setting ||= mock_model(Setting, stubs).as_null_object
  end
  
  describe "GET 'index'" do
    it "should be successful" do
      
      get :index
      response.should be_success
    end
    
    it "assing the first setting as @setting" do
      Setting.stub(:first) {mock_setting}
      get :index
      assigns(:setting).should be(mock_setting)
    end
  end

  describe "PUT update" do
    context "with valid params" do
      def do_put
        Setting.stub(:first) {mock_setting(:update_attributes => true)}
        post :update, :id => mock_setting.id
      end
      it "assigns the requested setting as @setting" do
        do_put
        assigns(:setting).should be(mock_setting)
      end
      
      it "updates the setting" do
        Setting.stub(:first) { mock_setting(:update_attributes => true) }
        mock_setting.should_receive(:update_attributes).with({'these' => 'params'})
        post :update, :id => mock_setting.id, :setting => {'these' => 'params'}
      end
      
      it "redirect to settings index" do
        do_put
        response.should redirect_to(admin_settings_path)
      end
      
      it "show a flash notice" do
        do_put
        flash[:notice].should_not be_nil
      end
    end

    context "with invalid params" do
      def do_put
        Setting.stub(:first) { mock_setting(:update_attributes => false) }
        put :update, :id => mock_setting.id
      end
      
      it "assigns the setting as @setting" do
        do_put
        assigns(:setting).should be(mock_setting)
      end
    end
  end

end
