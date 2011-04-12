require 'spec_helper'

describe HomeController do
  
  describe "GET index" do
    it "be success" do
      get :index
      response.should be_success
    end
  end
end
