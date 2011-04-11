module Admin::UsersHelper
  def user_type(user)
    user.admin? ? "Admin" : "Staff" 
  end
end
