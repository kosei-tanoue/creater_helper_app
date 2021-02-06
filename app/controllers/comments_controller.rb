class CommentsController < ApplicationController

  def create
    if comment = Comment.create(comment_params)
     redirect_to "/requests/#{comment.request.id}"
    else
      render "/requests/#{comment.request.id}"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, request_id: params[:request_id])
  end
end
