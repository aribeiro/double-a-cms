require 'spec_helper'

describe User do
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password)}
  
  describe "callbacks" do
    context "after create" do
      before :each do
        @user = Factory.create(:user)
      end
      context "activity log" do
        before :each do
          @activity = ActivityLog::Activity.last
        end
        
        it "should create a :created activity log to the object" do
          @activity.klass.should  == "User"
          @activity.action.should == "created"
          @activity.target["_id"].should == @user.id
        end
      end
    end

    context "after update" do
      before :each do
        @user = Factory.create(:user)
        @user.name = "my name"
        @user.save
      end
      context "activity log" do
        before :each do
          @activity = ActivityLog::Activity.last
        end
        
        it "should create a :updated activity log to the object" do
          @activity.klass.should  == "User"
          @activity.action.should == "updated"
          @activity.target["_id"].should == @user.id
        end
      end

    end
    context "after destroy" do
      before :each do
        @user = Factory.create(:user)
        @user.destroy
      end
      context "activity log" do
        before :each do
          @activity = ActivityLog::Activity.last
        end
        
        it "should create a :deleted activity log to the object" do
          @activity.klass.should  == "User"
          @activity.action.should == "deleted"
          @activity.target["_id"].should == @user.id
        end
      end

    end
  end
end
