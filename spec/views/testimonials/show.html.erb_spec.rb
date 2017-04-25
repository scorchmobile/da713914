require 'rails_helper'

RSpec.describe "testimonials/show", type: :view do
  before(:each) do
    @testimonial = assign(:testimonial, Testimonial.create!(
      :image => "Image",
      :author => "Author",
      :content => "Content",
      :css_bottom => "Css Bottom",
      :css_left => "Css Left",
      :testimonial_type => "Testimonial Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Image/)
    expect(rendered).to match(/Author/)
    expect(rendered).to match(/Content/)
    expect(rendered).to match(/Css Bottom/)
    expect(rendered).to match(/Css Left/)
    expect(rendered).to match(/Testimonial Type/)
  end
end
