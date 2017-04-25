require 'rails_helper'

RSpec.describe "sections/index", type: :view do
  before(:each) do
    assign(:sections, [
      Section.create!(
        :page => nil,
        :title => "Title",
        :content => "MyText",
        :visible => false,
        :private => false,
        :image => "Image"
      ),
      Section.create!(
        :page => nil,
        :title => "Title",
        :content => "MyText",
        :visible => false,
        :private => false,
        :image => "Image"
      )
    ])
  end

  it "renders a list of sections" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
  end
end
