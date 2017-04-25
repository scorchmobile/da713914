require 'rails_helper'

RSpec.describe "testimonials/index", type: :view do
  before(:each) do
    assign(:testimonials, [
      Testimonial.create!(
        :image => "Image",
        :author => "Author",
        :content => "Content",
        :css_bottom => "Css Bottom",
        :css_left => "Css Left",
        :testimonial_type => "Testimonial Type"
      ),
      Testimonial.create!(
        :image => "Image",
        :author => "Author",
        :content => "Content",
        :css_bottom => "Css Bottom",
        :css_left => "Css Left",
        :testimonial_type => "Testimonial Type"
      )
    ])
  end

  it "renders a list of testimonials" do
    render
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    assert_select "tr>td", :text => "Css Bottom".to_s, :count => 2
    assert_select "tr>td", :text => "Css Left".to_s, :count => 2
    assert_select "tr>td", :text => "Testimonial Type".to_s, :count => 2
  end
end
