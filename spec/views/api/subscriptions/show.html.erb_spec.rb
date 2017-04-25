require 'rails_helper'

RSpec.describe "api/subscriptions/show", type: :view do
  before(:each) do
    @api_subscription = assign(:api_subscription, Api::Subscription.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
