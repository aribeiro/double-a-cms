require 'spec_helper'

describe Admin::PagesController do
  login_user

  def mock_page(stubs={})
    @mock_page ||= mock_model(Page, stubs).as_null_object
  end

  describe "GET 'index'" do
    it "assings all pages as @pages" do
      Page.stub(:all){[mock_page]}
      get :index
      assigns(:pages).should eq([mock_page])
    end
  end

  describe "GET 'new'" do
    it "assigns a new page as @page" do
      Page.stub(:new) {mock_page}
      get :new
      assigns(:page).should be(mock_page)
    end
  end

  describe "POST create" do
    context "with valid params" do
      def do_post
        Page.stub(:new).with({'these' => 'params'}) { mock_page(:save => true) }
        post :create, :page => {'these' => 'params'}
      end
      it "assigns a newly created page as @page" do
        do_post
        assigns(:page).should be(mock_page)
      end
      it "redirect to created page" do
        do_post
        response.should redirect_to(admin_page_url(mock_page))
      end
      it "show a flash notice" do
        do_post
        flash[:notice].should == "Page successfully created."
      end
    end
    
    context "with invalid params" do 
      def do_post
        Page.stub(:new){ mock_page(:save => false) }
        post :create, :page => {'these' => 'params'}
      end

      it "assigns a newly created but unsaved page as @page" do
        do_post
        assigns(:page).should be(mock_page)
      end
      
      it "render the new template" do
        do_post
        response.should render_template('new')
      end
    end
  end

  describe "GET 'edit'" do
    it "assigns the requested page as @page" do
      Page.stub(:find).with("37") { mock_page }
      get :edit, :id => "37"
      assigns(:page).should be(mock_page)
    end
  end

  describe "PUT update" do
    context "with valid params" do
      def do_put
        Page.stub(:find).with("37"){mock_page(:update_attributes => true)}
        post :update, :id => "37"
      end
      it "assigns the requested page as @page" do
        do_put
        assigns(:page).should be(mock_page)
      end
      
      it "updates the requested page" do
        Page.stub(:find).with("37"){mock_page(:update_attributes => true)}
        mock_page.should_receive(:update_attributes).with({'these' => 'params'})
        post :update, :id => "37", :page => {'these' => 'params'}
      end
      
      it "redirect to updated page" do
        do_put
        response.should redirect_to(admin_page_path(mock_page))
      end
      
      it "show a flash notice" do
        do_put
        flash[:notice].should == "Page successfully updated."
      end
    end

    context "with invalid params" do
      def do_put
        Page.stub(:find) { mock_page(:update_attributes => false) }
        put :update, :id => "37"
      end
      
      it "assigns the page as @page" do
        do_put
        assigns(:page).should be(mock_page)
      end
      
      it "re-render the 'edit' template" do
        do_put
        response.should render_template("edit")  
      end
    end
  end
  
  describe "DELETE destroy" do
    def do_delete
      Page.stub(:find).with("37") { mock_page }
      mock_page.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
    it "destroys the requested page" do
      do_delete
    end
    
    it "redirects to pages list" do
      do_delete
      response.should redirect_to(admin_pages_path)
    end
    
    it "show a flash notice" do
      do_delete
      flash[:notice].should == "Page successfully destroyed."
    end
  end
end
