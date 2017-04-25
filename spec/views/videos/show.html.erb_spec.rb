require 'rails_helper'

RSpec.describe "videos/show", type: :view do
  before(:each) do
    @video = assign(:video, Video.create!(
      :hyperlink => "Hyperlink",
      :position => "Position",
      :link_text => "Link Text"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Hyperlink/)
    expect(rendered).to match(/Position/)
    expect(rendered).to match(/Link Text/)
  end
end
