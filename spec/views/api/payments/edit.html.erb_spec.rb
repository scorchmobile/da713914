require 'rails_helper'

RSpec.describe "api/payments/edit", type: :view do
  before(:each) do
    @api_payment = assign(:api_payment, Api::Payment.create!())
  end

  it "renders the edit api_payment form" do
    render

    assert_select "form[action=?][method=?]", api_payment_path(@api_payment), "post" do
    end
  end
end
