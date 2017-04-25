require 'rails_helper'

RSpec.describe "categories/edit", type: :view do
  before(:each) do
    @category = assign(:category, Category.create!(
      :name => "MyString",
      :permalink => "MyString",
      :description => "MyString",
      :image => "MyString",
      :visible => false,
      :position => 1
    ))
  end

  it "renders the edit category form" do
    render

    assert_select "form[action=?][method=?]", category_path(@category), "post" do

      assert_select "input#category_name[name=?]", "category[name]"

      assert_select "input#category_permalink[name=?]", "category[permalink]"

      assert_select "input#category_description[name=?]", "category[description]"

      assert_select "input#category_image[name=?]", "category[image]"

      assert_select "input#category_visible[name=?]", "category[visible]"

      assert_select "input#category_position[name=?]", "category[position]"
    end
  end
end
