class CommentsController < ApplicationController
  before_action :redirect_to_show

  def create
    @comment = Comment.new(comment_params)
    if @comment.valid?
      @comment.save
      if @comment.save
        ActionCable.server.broadcast 'comment_channel', content: @comment
      end
    else
      redirect_to item_path(params[:item_id])
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def redirect_to_show
    if user_signed_in? && current_user.id == Item.find(params[:item_id]).user_id
      redirect_to item_path(params[:item_id])
    end
  end

end
