class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post=Post.new
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      flash[:notice]="Post successfully created. Start editing!"
      redirect_to edit_post_path(@post)
    end
  end

  def edit
    @post=Post.find(params[:id])
  end

  def update
    @post=Post.find(params[:id])

    if @post.update_attributes(params[:post])
      render json: {
          status:"success"
      }
    else
      render json: {
          status:"failed"
      }
    end

  end
end
