require 'rails_helper'

RSpec.describe "sections/new", type: :view do
  before(:each) do
    assign(:section, Section.new(
      :page => nil,
      :title => "MyString",
      :content => "MyText",
      :visible => false,
      :private => false,
      :image => "MyString"
    ))
  end

  it "renders new section form" do
    render

    assert_select "form[action=?][method=?]", sections_path, "post" do

      assert_select "input#section_page_id[name=?]", "section[page_id]"

      assert_select "input#section_title[name=?]", "section[title]"

      assert_select "textarea#section_content[name=?]", "section[content]"

      assert_select "input#section_visible[name=?]", "section[visible]"

      assert_select "input#section_private[name=?]", "section[private]"

      assert_select "input#section_image[name=?]", "section[image]"
    end
  end
end
