class ItemRequestBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notice)

    sender = User.find(notice.sender_id)
    receipient = User.find(notice.recipient_id)
    _body = notice.body
    @unread_notifications = Notice.where(:recipient_id => notice.recipient_id, :read_at=>nil).order('created_at desc')

    ActionCable.server.broadcast(
      "notifications_#{receipient.id}",
      body: _body,
      sender_id: sender.id,
      unread_notifications_count: @unread_notifications.length,
      notice: render_item_request(sender, notice)
    )

  end

  private

  def render_item_request(sender, notice)
    ApplicationController.render(
      partial: 'requests/item_request',
      locals: { notice: notice }
    )
  end

end
