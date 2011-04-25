require 'spec_helper'

describe Page do
  it {should embed_one(:seo) }
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:content)}

  
  describe "callbacks" do
    context "after create" do
      before :each do
        @page = Factory.create(:page)
      end
      context "activity log" do
        before :each do
          @activity = ActivityLog::Activity.last
        end
        
        it "should create a :created activity log to the object" do
          @activity.klass.should  == "Page"
          @activity.action.should == "created"
          @activity.target["_id"].should == @page.id
        end
      end
    end

    context "after update" do
      before :each do
        @page = Factory.create(:page)
        @page.title = "my update test"
        @page.save
      end
      context "activity log" do
        before :each do
          @activity = ActivityLog::Activity.last
        end
        
        it "should create a :updated activity log to the object" do
          @activity.klass.should  == "Page"
          @activity.action.should == "updated"
          @activity.target["_id"].should == @page.id
        end
      end

    end
    context "after destroy" do
      before :each do
        @page = Factory.create(:page)
        @page.destroy
      end
      context "activity log" do
        before :each do
          @activity = ActivityLog::Activity.last
        end
        
        it "should create a :deleted activity log to the object" do
          @activity.klass.should  == "Page"
          @activity.action.should == "deleted"
          @activity.target["_id"].should == @page.id
        end
      end

    end
  end
end
