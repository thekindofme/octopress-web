class BlogsController < ApplicationController
  def index
    @blogs = Blog.all
  end

  def new
    @blog=Blog.new
  end

  def create
    @blog = Blog.new(params[:blog])

    if @blog.save
      flash[:notice]="Blog successfully created."
      redirect_to blogs_path
    end
  end

  def destroy
    @blog = Blog.find(params[:id])

    if @blog.destroy
      flash[:notice]="Blog deleted."
    else
      flash[:notice]="Something went wrong."
    end

    redirect_to blogs_path
  end

  def select
    @current_blog= Blog.find(params[:id])
    cookies[:current_blog] = @current_blog.id

    flash[:notice] = "Swithced the current blog to #{@current_blog.name}"
    redirect_to blogs_path
  end

  def deploy
    current_blog.deploy.delay
  end
end
