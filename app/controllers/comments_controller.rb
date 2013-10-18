class CommentsController < ApplicationController
  expose_decorated(:post)
  expose_decorated(:comment)
  expose_decorated(:comments)
  def new
    @comment = Comment.new
    @comment.post = post unless post.nil?

    
  end


  def edit
    @comment = Comment.find(params[:id])
  end


  def create
    @comment = Comment.new(params[:comment])
    @comment.post = post unless post.nil?
    if @comment.save
      redirect_to post_path(post), notice: 'Comment was successfully created.'
    else
      render action: "new"   
    end
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update_attributes(params[:comment])
      redirect_to post_path(post), notice: 'Comment was successfully updated.'
    else
      render action: "edit"
    end
  end


  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to [post, @comment] 
         
  end

  def vote_up
    comment.votes.up.create(user: current_user)
    redirect_to post_path(post)
  end

  def vote_down
    comment.votes.down.create(user: current_user)
    redirect_to post_path(post)
  end


end
