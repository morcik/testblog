class PostsController < ApplicationController
  before_filter :authenticate_user!
  expose_decorated(:posts)
  expose_decorated(:post)
  expose_decorated(:comments)
  expose(:tag_cloud) { [] }

  def index
  end

  def new
    post.user = current_user
  end

  def edit
  end

  def update
    if post.save
      render action: :show
    else
      render :new
    end
  end

  def destroy
    post.destroy if current_user.owner? post
    render action: :index
  end
  def comments
    if current_user.owner?(post)
      post.comments
    else
      post.comments.not_abusives
    end
  end
  def show
  end

  def mark_archived
    post.archive!
    render action: :index
  end

  def create
    post.user = current_user
    if post.save
      redirect_to action: :index
    else
      render :new
    end
  end

end
