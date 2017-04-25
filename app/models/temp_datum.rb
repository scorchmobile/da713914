class TempDatum < ApplicationRecord
  
  # Validation
  validates :first_name, :last_name, :email, :phone, :member_type, presence: true
  #validates :email, format: { with: %r{/^[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i} }, presence: true, allow_blank: true
  
  after_create :send_pre_registration_email
  def send_pre_registration_email
    case self.member_type
    when 'Deputy'
      EnrollmentResponderMailer.pre_register_deputy(self).deliver_now
    when 'Family'
      EnrollmentResponderMailer.pre_register_family(self).deliver_now
    when 'Both'
      EnrollmentResponderMailer.pre_register_both(self).deliver_now
    end
  end
  
end
