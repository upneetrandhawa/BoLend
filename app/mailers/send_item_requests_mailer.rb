class SendItemRequestsMailer < ApplicationMailer
    default :from => 'no-reply@easyshare.com'

    def send_requesting_item(email, description, name)
        @description = description
        @name = name
        @email = email
        mail(to: email, subject: "#{name} is looking for #{description}")
    end
end
