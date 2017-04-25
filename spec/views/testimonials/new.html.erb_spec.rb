require 'rails_helper'

RSpec.describe "testimonials/new", type: :view do
  before(:each) do
    assign(:testimonial, Testimonial.new(
      :image => "MyString",
      :author => "MyString",
      :content => "MyString",
      :css_bottom => "MyString",
      :css_left => "MyString",
      :testimonial_type => "MyString"
    ))
  end

  it "renders new testimonial form" do
    render

    assert_select "form[action=?][method=?]", testimonials_path, "post" do

      assert_select "input#testimonial_image[name=?]", "testimonial[image]"

      assert_select "input#testimonial_author[name=?]", "testimonial[author]"

      assert_select "input#testimonial_content[name=?]", "testimonial[content]"

      assert_select "input#testimonial_css_bottom[name=?]", "testimonial[css_bottom]"

      assert_select "input#testimonial_css_left[name=?]", "testimonial[css_left]"

      assert_select "input#testimonial_testimonial_type[name=?]", "testimonial[testimonial_type]"
    end
  end
end
