class EventMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.subscription.subject
  #
  def subscription(event, subscr)

    @email = subscr.user_email
    @name = subscr.user_name
    @event = event

    mail to: event.user.email, subject: "Новая подписка на #{event.title}"
  end

  def photo(event,photo,email)
    @photo = photo
    @event = event
    mail to: email, subject: "Новая фотография @ #{event.title}"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.comment.subject
  #
  def comment(event,comment,email)
    @comment = comment
    @event = event

    mail to: email, subject: "Новый комментарий @ #{event.title}"
  end
end
