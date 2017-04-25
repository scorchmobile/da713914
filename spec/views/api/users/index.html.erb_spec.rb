require 'rails_helper'

RSpec.describe "api/users/index", type: :view do
  before(:each) do
    assign(:api_users, [
      Api::User.create!(),
      Api::User.create!()
    ])
  end

  it "renders a list of api/users" do
    render
  end
end
