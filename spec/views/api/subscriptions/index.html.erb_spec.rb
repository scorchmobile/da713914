require 'rails_helper'

RSpec.describe "api/subscriptions/index", type: :view do
  before(:each) do
    assign(:api_subscriptions, [
      Api::Subscription.create!(),
      Api::Subscription.create!()
    ])
  end

  it "renders a list of api/subscriptions" do
    render
  end
end
