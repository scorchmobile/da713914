require 'rails_helper'

RSpec.describe "facts/show", type: :view do
  before(:each) do
    @fact = assign(:fact, Fact.create!(
      :headline => "Headline",
      :line_one => "Line One",
      :line_two => "Line Two"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Headline/)
    expect(rendered).to match(/Line One/)
    expect(rendered).to match(/Line Two/)
  end
end
