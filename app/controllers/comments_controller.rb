class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to post_path(@post), notice: 'Comment was successfully created.'
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
      if @comment.update_attributes(comment_params)
        redirect_to @post, notice: 'Comment was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post), notice: 'Comment was successfully destroyed.'
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :comment).merge(user_id: current_user.id)
  end

end
