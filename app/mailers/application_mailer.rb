class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@mycookbook.com'
  layout 'mailer'
end
