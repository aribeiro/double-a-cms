require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the Admin::UsersHelper. For example:
#
# describe Admin::UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe Admin::UsersHelper do
  describe "User Type" do
    it "should show 'admin' when user is an admin" do
      admin = Factory(:admin)
      helper.user_type(admin).should == "Admin"
    end
    
    it "should show 'staff' when user is not admin" do
      user = Factory(:user)
      helper.user_type(user).should == "Staff"
    end
  end
end
