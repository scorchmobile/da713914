require 'rails_helper'

RSpec.describe "products/new", type: :view do
  before(:each) do
    assign(:product, Product.new(
      :category => nil,
      :price => "9.99",
      :name => "MyString",
      :description => "MyText",
      :image => "MyString",
      :visible => false,
      :position => 1,
      :permalink => "MyString"
    ))
  end

  it "renders new product form" do
    render

    assert_select "form[action=?][method=?]", products_path, "post" do

      assert_select "input#product_category_id[name=?]", "product[category_id]"

      assert_select "input#product_price[name=?]", "product[price]"

      assert_select "input#product_name[name=?]", "product[name]"

      assert_select "textarea#product_description[name=?]", "product[description]"

      assert_select "input#product_image[name=?]", "product[image]"

      assert_select "input#product_visible[name=?]", "product[visible]"

      assert_select "input#product_position[name=?]", "product[position]"

      assert_select "input#product_permalink[name=?]", "product[permalink]"
    end
  end
end
