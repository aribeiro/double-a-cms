# -*- encoding : utf-8 -*-
class Admin::ApplicationController < ApplicationController
  layout "admin"
  before_filter :authenticate_user!
end
