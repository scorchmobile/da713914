require 'rails_helper'

RSpec.describe "facts/index", type: :view do
  before(:each) do
    assign(:facts, [
      Fact.create!(
        :headline => "Headline",
        :line_one => "Line One",
        :line_two => "Line Two"
      ),
      Fact.create!(
        :headline => "Headline",
        :line_one => "Line One",
        :line_two => "Line Two"
      )
    ])
  end

  it "renders a list of facts" do
    render
    assert_select "tr>td", :text => "Headline".to_s, :count => 2
    assert_select "tr>td", :text => "Line One".to_s, :count => 2
    assert_select "tr>td", :text => "Line Two".to_s, :count => 2
  end
end
