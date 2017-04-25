require 'rails_helper'

RSpec.describe "api/payments/index", type: :view do
  before(:each) do
    assign(:api_payments, [
      Api::Payment.create!(),
      Api::Payment.create!()
    ])
  end

  it "renders a list of api/payments" do
    render
  end
end
