class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]


  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
  end
end
