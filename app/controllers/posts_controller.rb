class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(:comments).where(author_id: @user.id).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:user_id])

    begin
      @post = Post.where(author_id: @user.id).find(params[:id])
    rescue StandardError
      @post = nil
    end
    session[:return_to] ||= request.referer
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(author_id: current_user.id, **post_params)

    if @post.save
      flash[:notice] = 'Your post was created successfully'
      redirect_to user_posts_path(params[:user_id])
    else
      flash[:alert] = 'Sorry, something went wrong!'
      render :new
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.comments.each(&:destroy)
    post.likes.each(&:destroy)
    post.destroy
    redirect_to user_posts_path(params[:user_id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
