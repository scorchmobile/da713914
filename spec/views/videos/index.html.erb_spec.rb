require 'rails_helper'

RSpec.describe "videos/index", type: :view do
  before(:each) do
    assign(:videos, [
      Video.create!(
        :hyperlink => "Hyperlink",
        :position => "Position",
        :link_text => "Link Text"
      ),
      Video.create!(
        :hyperlink => "Hyperlink",
        :position => "Position",
        :link_text => "Link Text"
      )
    ])
  end

  it "renders a list of videos" do
    render
    assert_select "tr>td", :text => "Hyperlink".to_s, :count => 2
    assert_select "tr>td", :text => "Position".to_s, :count => 2
    assert_select "tr>td", :text => "Link Text".to_s, :count => 2
  end
end
