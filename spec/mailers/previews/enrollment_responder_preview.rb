# Preview all emails at http://localhost:3000/rails/mailers/enrollment_responder
class EnrollmentResponderPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/enrollment_responder/pre_register_deputy
  def pre_register_deputy
    EnrollmentResponderMailer.pre_register_deputy
  end

  # Preview this email at http://localhost:3000/rails/mailers/enrollment_responder/pre_register_family
  def pre_register_family
    EnrollmentResponderMailer.pre_register_family
  end

end
