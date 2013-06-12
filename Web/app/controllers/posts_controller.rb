class PostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy
  
  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.paginate(page: params[:page])
    @post = current_user.posts.build if signed_in?
  end

  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Post created !"
      redirect_to posts_path
    else
      render "posts/index"
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private
    def correct_user
      @post = Post.find(params[:id]) if current_user.admin?
      @post ||= current_user.posts.find_by_id(params[:id])
    
      redirect_to posts_path if @post.nil? 
    rescue
      redirect_to posts_path
    end
end
