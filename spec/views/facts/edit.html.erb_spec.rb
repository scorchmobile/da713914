require 'rails_helper'

RSpec.describe "facts/edit", type: :view do
  before(:each) do
    @fact = assign(:fact, Fact.create!(
      :headline => "MyString",
      :line_one => "MyString",
      :line_two => "MyString"
    ))
  end

  it "renders the edit fact form" do
    render

    assert_select "form[action=?][method=?]", fact_path(@fact), "post" do

      assert_select "input#fact_headline[name=?]", "fact[headline]"

      assert_select "input#fact_line_one[name=?]", "fact[line_one]"

      assert_select "input#fact_line_two[name=?]", "fact[line_two]"
    end
  end
end
