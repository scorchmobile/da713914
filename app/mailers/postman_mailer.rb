class PostmanMailer < ApplicationMailer
  
  default from: %{"Auto-Mailer" <autobot@deputizeamerica.org>}
  default to: "info@deputizeamerica.org"
  
  def contact_form message
    @message = message
    mail subject: "#{Time.now.in_time_zone("Central Time (US & Canada)").strftime("%b %d, %Y")} - #{@message.member_type} Pre-Registration"
  end
  
end
