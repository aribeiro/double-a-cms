# -*- encoding : utf-8 -*-
class Admin::ApplicationController < ApplicationController
  before_filter :authenticate_user!
end
