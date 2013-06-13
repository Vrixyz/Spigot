class PostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy
  
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
      @posts = Post.paginate(page: params[:page])
      redirect_to posts_path
    else
      # flash[:error] = "Couldn't create post."
      render "posts/index"
    end
  end

  def edit
    @post = Post.find(params[:id])
    @posts = Post.paginate(page:params[:page])
    render 'posts/index'
    # render action: "index"
  end
 
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      flash[:success] = "Successfully updated post."
      @posts = Post.all
      redirect_to posts_path
    else
      render :action => 'index'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Successfully destroyed post."
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
