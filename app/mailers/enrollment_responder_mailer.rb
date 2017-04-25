class EnrollmentResponderMailer < ApplicationMailer
  
  default from: %{"Information" <info@deputizeamerica.org>}
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.enrollment_responder_mailer.pre_register_deputy.subject
  #
  def pre_register_deputy(record)
    @registration_info = record

    mail to: @registration_info.email, subject: 'Welcome to Deputize America'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.enrollment_responder_mailer.pre_register_family.subject
  #
  def pre_register_family(record)
    @registration_info = record

    mail to: @registration_info.email, subject: 'Welcome to Deputize America'
  end
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.enrollment_responder_mailer.pre_register_both.subject
  #
  def pre_register_both(record)
    @registration_info = record

    mail to: @registration_info.email, subject: 'Welcome to Deputize America'
  end
end
