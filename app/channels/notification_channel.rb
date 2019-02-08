class NotificationChannel < ApplicationCable::Channel
  def subscribed
    puts "NOTIFICATION CHANNEL SUBSCRIBED"
    stream_from "notifications_#{current_user.id}"
  end

  def unsubscribed
    puts "NOTIFICATION CHANNEL UNSUBSCRIBED"
    stop_all_streams
  end

  def contact_request_response(data)
       puts "NOTIFICATION CHANNEL contact_request_response"
    _receipient_id = data['receipient_id']
    _sender_id = data['sender_id']
    _notification = data['body']
    _receipient = User.find(receipient_id)

    ActionCable.server.broadcast(
      "notifications_#{_receipient_id}",
      notification: _notification,
      sender_id: _sender_id,
    )

  end

end
