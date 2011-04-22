# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      devise_admin = Factory.create(:admin) 
      sign_in devise_admin
      request.env['warden'] = mock(Warden, :authenticate => devise_admin,
                                       :authenticate! => devise_admin)
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      devise_user = Factory.create(:user) 
      sign_in devise_user
      request.env['warden'] = mock(Warden, :authenticate => devise_user,
                                       :authenticate! => devise_user)
    end
  end
end

RSpec.configure do |config|
  config.include Mongoid::Matchers
  config.include Devise::TestHelpers, :type => :controller
  config.extend ControllerMacros, :type => :controller

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = "mongoid"
    I18n.locale = :en
  end

  config.after(:each) do
    DatabaseCleaner.clean unless example.metadata[:keep]
  end

  config.mock_with :rspec
  
  config.filter_run :focus => false
  config.run_all_when_everything_filtered = true
end


