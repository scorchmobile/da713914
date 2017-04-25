require 'rails_helper'

RSpec.describe "pages/new", type: :view do
  before(:each) do
    assign(:page, Page.new(
      :title => "MyString",
      :visible => false,
      :private => false,
      :permalink => "MyString"
    ))
  end

  it "renders new page form" do
    render

    assert_select "form[action=?][method=?]", pages_path, "post" do

      assert_select "input#page_title[name=?]", "page[title]"

      assert_select "input#page_visible[name=?]", "page[visible]"

      assert_select "input#page_private[name=?]", "page[private]"

      assert_select "input#page_permalink[name=?]", "page[permalink]"
    end
  end
end
