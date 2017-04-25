require 'rails_helper'

RSpec.describe "pages/edit", type: :view do
  before(:each) do
    @page = assign(:page, Page.create!(
      :title => "MyString",
      :visible => false,
      :private => false,
      :permalink => "MyString"
    ))
  end

  it "renders the edit page form" do
    render

    assert_select "form[action=?][method=?]", page_path(@page), "post" do

      assert_select "input#page_title[name=?]", "page[title]"

      assert_select "input#page_visible[name=?]", "page[visible]"

      assert_select "input#page_private[name=?]", "page[private]"

      assert_select "input#page_permalink[name=?]", "page[permalink]"
    end
  end
end
