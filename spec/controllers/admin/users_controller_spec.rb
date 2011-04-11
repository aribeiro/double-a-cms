require 'spec_helper'

describe Admin::UsersController do
  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  describe "GET index" do
    it "assings all users as @users" do
      User.stub(:all){[mock_user]}
      get :index
      assigns(:users).should eq([mock_user])
    end
  end

  describe "GET new" do
    it "assigns a new user as @user" do
      User.stub(:new) {mock_user}
      get :new
      assigns(:user).should be(mock_user)
    end
  end

  describe "POST create" do
    context "with valid params" do
      def do_post
        User.stub(:new).with({'these' => 'params'}) { mock_user(:save => true) }
        post :create, :user => {'these' => 'params'}
      end
      it "assigns a newly created user as @user" do
        do_post
        assigns(:user).should be(mock_user)
      end

      it "redirect to users list" do
        do_post
        response.should redirect_to(admin_users_path)
      end
      
      it "show a flash notice" do
        do_post
        assigns(:user).should be(mock_user)
        flash[:notice].should == "User successfully created."
      end
    end

    context "with invalid params" do
      def do_post
        User.stub(:new){ mock_user(:save => false) }
        post :create, :user => {'these' => 'params'}
      end

      it "assigns a newly created but unsaved user as @user" do
        do_post
        assigns(:user).should be(mock_user)
      end
      
      it "render the new template" do
        do_post
        response.should render_template("new")
      end
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      User.stub(:find).with("37") { mock_user }
      get :edit, :id => "37"
      assigns(:user).should be(mock_user)
    end
  end
  
  describe "PUT update" do
    context "with valid params" do
      it "assigns the requested user as @user" do
        User.stub(:find).with("37"){mock_user(:update_attributes => true)}
        post :update, :id => "37"
        assigns(:user).should be(mock_user)
      end
      
      it "updates the requested user" do
        User.stub(:find).with("37"){mock_user(:update_attributes => true)}
        mock_user.should_receive(:update_attributes).with({'these' => 'params'})
        post :update, :id => "37", :user => {'these' => 'params'}
      end
      
      it "redirect to users list" do
        User.stub(:find).with("37"){mock_user(:update_attributes => true)}
        post :update, :id => "37"
        response.should redirect_to(admin_users_path)
      end
      
      it "show a flash notice" do
        User.stub(:find).with("37"){mock_user(:update_attributes => true)}
        post :update, :id => "37"
        flash[:notice].should == "User successfully updated."
      end
    end

    context "with invalid params" do
      def do_put
        User.stub(:find) { mock_user(:update_attributes => false) }
        put :update, :id => "37"
      end
      
      it "assigns the category as @category" do
        do_put
        assigns(:user).should be(mock_user)
      end
      
      it "re-render the 'edit' template" do
        do_put
        response.should render_template("edit")  
      end
    end
  end

  describe "DELETE destroy" do
    def do_delete
      User.stub(:find).with("37") { mock_user }
      mock_user.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
    it "destroys the requested user" do
      do_delete
    end
    
    it "redirects to users list" do
      do_delete
      response.should redirect_to(admin_users_path)
    end
    
    it "show a flash notice" do
      do_delete
      flash[:notice].should == "User successfully destoyed."
    end
  end
end
