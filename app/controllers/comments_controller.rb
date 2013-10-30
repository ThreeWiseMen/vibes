class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @comment = Comment.new(params.require(:comment).permit(:idea_id, :comment))
    @comment.user = current_user
    puts @comment.errors.messages
    @comment.save
    redirect_to idea_path(@comment.idea)
  end
end
