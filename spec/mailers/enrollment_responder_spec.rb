require "rails_helper"

RSpec.describe EnrollmentResponderMailer, type: :mailer do
  describe "pre_register_deputy" do
    let(:mail) { EnrollmentResponderMailer.pre_register_deputy }

    it "renders the headers" do
      expect(mail.subject).to eq("Pre register deputy")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "pre_register_family" do
    let(:mail) { EnrollmentResponderMailer.pre_register_family }

    it "renders the headers" do
      expect(mail.subject).to eq("Pre register family")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
