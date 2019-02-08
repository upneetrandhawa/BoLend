class DueDateEmailMailer < ApplicationMailer
    default :from => 'no-reply@easyshare.com'
    def send_due_date_email(email, description, borrower_name)
        @description = description
        @borrower_name = borrower_name
        mail(to: email, subject: "Your due date for #{description} is approaching")
    end
end
