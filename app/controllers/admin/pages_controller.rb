class Admin::PagesController < ApplicationController
  before_filter :find_page, :only => [:show, :edit, :update, :destroy]
  
  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = "Page successfully created."
      redirect_to [:admin, @page]
    else
      render :action => :new
    end
  end

  def update
    if @page.update_attributes(params[:page])
      flash[:notice] = "Page successfully updated."
      redirect_to [:admin, @page]
    else
      render :action => :edit
    end
  end

  def destroy
    @page.destroy
    flash[:notice] = "Page successfully destroyed."
    redirect_to admin_pages_path
  end

  protected
  def find_page
    @page = Page.find(params[:id])
  end
end
