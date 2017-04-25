require 'rails_helper'

RSpec.describe "videos/edit", type: :view do
  before(:each) do
    @video = assign(:video, Video.create!(
      :hyperlink => "MyString",
      :position => "MyString",
      :link_text => "MyString"
    ))
  end

  it "renders the edit video form" do
    render

    assert_select "form[action=?][method=?]", video_path(@video), "post" do

      assert_select "input#video_hyperlink[name=?]", "video[hyperlink]"

      assert_select "input#video_position[name=?]", "video[position]"

      assert_select "input#video_link_text[name=?]", "video[link_text]"
    end
  end
end
