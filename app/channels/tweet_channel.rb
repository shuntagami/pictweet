class TweetChannel < ApplicationCable::Channel
  def subscribed
    stream_from "tweet_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def destroy(data)
    ActionCable.server.broadcast 'room_channel', comment: data['comment']
    comment.destroy
  end
end
