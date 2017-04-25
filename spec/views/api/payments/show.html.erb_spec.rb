require 'rails_helper'

RSpec.describe "api/payments/show", type: :view do
  before(:each) do
    @api_payment = assign(:api_payment, Api::Payment.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
