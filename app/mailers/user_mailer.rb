class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

    def notify_deadline_email(active_item)
      #borrower to whom to send email.
      @active_item=active_item
      @borrower=User.find_by_id(@active_item.borrower_id)
      #@borrower_name=User.find_by_id(@transaction.borrower_id).first_name
      @lender_name=User.find_by_id(@active_item.lender_id).first_name
      @item_description=Item.find_by_id(@active_item.item_id).description
      @start_date=@@active_item.start_date
      @due_date=@active_item.due_date
      mail(to: @borrower.email, subject: 'You have a deadline approaching for an item borrowed')
    end

end
