require 'rails_helper'

RSpec.describe "api/subscriptions/edit", type: :view do
  before(:each) do
    @api_subscription = assign(:api_subscription, Api::Subscription.create!())
  end

  it "renders the edit api_subscription form" do
    render

    assert_select "form[action=?][method=?]", api_subscription_path(@api_subscription), "post" do
    end
  end
end
