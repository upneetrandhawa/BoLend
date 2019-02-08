namespace :notification do
  desc "Send notification emails to users that are past due dates or approaching due dates."
  task send_due_date: :environment do
    SendDueDateEmailsJob.perform_now
  end

end
