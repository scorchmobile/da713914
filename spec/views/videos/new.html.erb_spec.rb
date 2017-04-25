require 'rails_helper'

RSpec.describe "videos/new", type: :view do
  before(:each) do
    assign(:video, Video.new(
      :hyperlink => "MyString",
      :position => "MyString",
      :link_text => "MyString"
    ))
  end

  it "renders new video form" do
    render

    assert_select "form[action=?][method=?]", videos_path, "post" do

      assert_select "input#video_hyperlink[name=?]", "video[hyperlink]"

      assert_select "input#video_position[name=?]", "video[position]"

      assert_select "input#video_link_text[name=?]", "video[link_text]"
    end
  end
end
