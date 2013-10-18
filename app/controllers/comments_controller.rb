class CommentsController < ApplicationController
  expose_decorated(:post)
  expose_decorated(:comment)
  expose_decorated(:comments)

  # GET /post/1/comments/new
  # GET /post/1/comments/new.json
  def new
    @comment = Comment.new
    @comment.post = post unless post.nil?

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /post/1/comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /post/1/comments
  # POST /post/1/comments.json
  def create
    @comment = Comment.new(params[:comment])
    @comment.post = post unless post.nil?
    if @comment.save
      redirect_to post_path(post), notice: 'Comment was successfully created.'
    else
      render action: "new"   
    end
  end

  # PUT /post/1/comments/1
  # PUT /post/1/comments/1.json
  def update
    @comment = Comment.find(params[:id])

    if @comment.update_attributes(params[:comment])
      redirect_to post_path(post), notice: 'Comment was successfully updated.'
    else
      render action: "edit"
      
    end
  end

  # DELETE /post/1/comments/1
  # DELETE /post/1/comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to [post, @comment] 
         
  end
end
