class CommentsController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])  
    @comment = Comment.new(comment_params)
    if @comment.save
      ActionCable.server.broadcast 'tweet_channel', 
      comment: @comment, user: @comment.user, time: I18n.l(@comment.created_at), tweet: @tweet
    else
      # redirect_to @comment.tweet, flash: {
      #   notice: @comment,
      #   error_messages: @comment.errors.full_messages
      # }
      flash.now[:alert] = 'メッセージを入力してください。'
      # render template: "tweets/show"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'コメントが削除されました'
    redirect_to @comment.tweet
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  end
end