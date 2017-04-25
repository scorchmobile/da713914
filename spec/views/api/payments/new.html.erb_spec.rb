require 'rails_helper'

RSpec.describe "api/payments/new", type: :view do
  before(:each) do
    assign(:api_payment, Api::Payment.new())
  end

  it "renders new api_payment form" do
    render

    assert_select "form[action=?][method=?]", api_payments_path, "post" do
    end
  end
end
