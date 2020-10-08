class TweetChannel < ApplicationCable::Channel
  def subscribed
    stream_from "tweet_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def break(data)
    Comment.destroy! content: data['comment']
  end
end
