# -*- encoding : utf-8 -*-
class Admin::UsersController < Admin::ApplicationController
  before_filter :find_user, :only => [:edit, :update, :destroy] 
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = t("notice.successfully.created", :model => t("models.user.name").capitalize)
      redirect_to admin_users_path
    else
      render :action => :new
    end
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = t("notice.successfully.updated", :model => t("models.user.name").capitalize)
      redirect_to admin_users_path
    else
      render :action => :edit
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = t("notice.successfully.destroyed", :model => t("models.user.name").capitalize)
    redirect_to(admin_users_path)
  end

  protected
  def find_user
    @user = User.find(params[:id])
  end
end
