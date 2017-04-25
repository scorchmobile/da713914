require 'rails_helper'

RSpec.describe "api/subscriptions/new", type: :view do
  before(:each) do
    assign(:api_subscription, Api::Subscription.new())
  end

  it "renders new api_subscription form" do
    render

    assert_select "form[action=?][method=?]", api_subscriptions_path, "post" do
    end
  end
end
