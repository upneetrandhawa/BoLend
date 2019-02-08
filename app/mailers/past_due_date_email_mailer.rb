class PastDueDateEmailMailer < ApplicationMailer
    default :from => 'no-reply@easyshare.com'
    #Send email notification for past due date 
    def send_past_due_date_email(email, description, borrower_name, due_date_past)
        @description = description
        @borrower_name = borrower_name
        @due_date_past = due_date_past
        mail(to: email, subject: "#{description} you borrowed is past the due date")
    end
end
