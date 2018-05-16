class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
  layout "mailer"

  def welcome_email(user_email, person_email, title, content)
    # @user = user
    @url = 'http://example.com/login'
    mail(from: user_email,
         to: person_email,
         subject: title,
         text: content
         )
  end
end