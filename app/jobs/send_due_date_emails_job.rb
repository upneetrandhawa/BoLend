class SendDueDateEmailsJob < ApplicationJob
  queue_as :default

  def perform
    active_items = ActiveItem.all
    active_items.each do |active_item|
      date_til_due = (active_item.due_date - Time.current).to_f / 1.day

      #Past the due date
      if date_til_due < 0
        item = Item.find(active_item.item_id)
        borrower = User.find(active_item.borrower_id)
        PastDueDateEmailMailer.send_past_due_date_email(borrower.email, item.description, borrower.first_name, date_til_due.to_i.abs).deliver
      elsif date_til_due.to_i == 1
        #Send reminder that the item is due in 1 day
        item = Item.find(active_item.item_id)
        borrower = User.find(active_item.borrower_id)
        DueDateEmailMailer.send_due_date_email(borrower.email, item.description, borrower.first_name).deliver
      end

    end 
    #DueDateEmailMailer.send_due_date_email.deliver    
  end
end
