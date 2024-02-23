class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @user.posts.build(post_params)

    if @post.save
      flash[:notice] = 'Post created ;)'
      redirect_to @post
    else
      flash[:alert] = 'Problem while creating the post :/'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
