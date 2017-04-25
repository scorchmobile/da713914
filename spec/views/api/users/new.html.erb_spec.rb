require 'rails_helper'

RSpec.describe "api/users/new", type: :view do
  before(:each) do
    assign(:api_user, Api::User.new())
  end

  it "renders new api_user form" do
    render

    assert_select "form[action=?][method=?]", api_users_path, "post" do
    end
  end
end
