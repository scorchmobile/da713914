require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        :category => nil,
        :price => "9.99",
        :name => "Name",
        :description => "MyText",
        :image => "Image",
        :visible => false,
        :position => 2,
        :permalink => "Permalink"
      ),
      Product.create!(
        :category => nil,
        :price => "9.99",
        :name => "Name",
        :description => "MyText",
        :image => "Image",
        :visible => false,
        :position => 2,
        :permalink => "Permalink"
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Permalink".to_s, :count => 2
  end
end
