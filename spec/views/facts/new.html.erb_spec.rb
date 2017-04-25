require 'rails_helper'

RSpec.describe "facts/new", type: :view do
  before(:each) do
    assign(:fact, Fact.new(
      :headline => "MyString",
      :line_one => "MyString",
      :line_two => "MyString"
    ))
  end

  it "renders new fact form" do
    render

    assert_select "form[action=?][method=?]", facts_path, "post" do

      assert_select "input#fact_headline[name=?]", "fact[headline]"

      assert_select "input#fact_line_one[name=?]", "fact[line_one]"

      assert_select "input#fact_line_two[name=?]", "fact[line_two]"
    end
  end
end
