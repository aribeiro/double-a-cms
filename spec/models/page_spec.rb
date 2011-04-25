# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Page do
  it {should embed_one(:seo) }
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:content)}

  describe "first_fifteen_words" do
    before :each do
      @page = Factory(:page, :title => "this is a super big title to test the fifteen words method from page model this title should be stripped for just only fifteen words")
    end

    it "should strip the title to fifteen words" do
      @page.first_fifteen_words.split("-").size.should == 15
    end

    it "remove all acentuation, no-ascii caracters, and extra spaces from the title" do
      @page.title = "acentuation olá      maçã -,;' \" / ? `      áäâ % <>() tést"
      @page.first_fifteen_words.should == "acentuation-ola-maca-aaa-test"
    end
  end
  
  describe "similar slug count" do
    it "should return the number of pages with similar slug" do
      3.times{ Factory.create(:page, :title => "my similar title") }
      @page = Factory.build(:page, :title => "my similar title")
      @page.similar_slugs_count.should == 3
    end
  end

  describe "next similar slug number" do
    it "should return biggest similar slug number with prefix -n + 1" do
      3.times{ Factory.create(:page, :title => "my similar title") }
      @page = Factory.build(:page, :title => "my similar title")
      @page.next_similar_slug_number.should == 3 
    end
  end


  describe "callbacks" do
    context "before create" do
      before :each do
        @page = Factory.build(:page) 
      end

      context "updated cached slug" do
        it "generate a slug" do
          @page.slug.should_not be_nil 
        end
        
        it "cached slug should be equal old slug" do
          @page.cached_slug.should == @page.old_slug
        end
      end
    end

    context "before update" do
      before :each do
        @page = Factory.create(:page) 
      end
      
      context "updated cached slug" do
        before :each do
          @page.title = "New title"
          @page.save
        end
        
        it "generate a slug" do
          @page.slug.should_not be_nil 
        end
        
        it "slug should not be equal old slug" do
          @page.slug.should_not == @page.old_slug
        end
      end
    end

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
