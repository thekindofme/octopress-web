class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_blogs, :current_blog

  private
  def set_blogs
    @blogs=Blog.all
  end

  def current_blog
    begin
    @current_blog= Blog.find(cookies[:current_blog] || params[:current_blog])
    rescue ActiveRecord::RecordNotFound
      # ignored
    end

    unless @current_blog
      respond_to do |format|
        format.html {
          @current_blog= Blog.first
          cookies[:current_blog] = @current_blog.id
        }

        format.json { render json: ({message:"Invalid Blog ID"}), status: :unprocessable_entity }
      end
      return false if request.format.json?
    end

    @current_blog
  end
end
