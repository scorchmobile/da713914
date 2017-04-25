require 'rails_helper'

RSpec.describe "categories/show", type: :view do
  before(:each) do
    @category = assign(:category, Category.create!(
      :name => "Name",
      :permalink => "Permalink",
      :description => "Description",
      :image => "Image",
      :visible => false,
      :position => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Permalink/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Image/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/2/)
  end
end
