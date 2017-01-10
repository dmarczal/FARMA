require 'rails_helper'

RSpec.describe "admin/researches/new", type: :view do
  before(:each) do
    assign(:admin_research, Admin::Research.new(
      :title => "MyString",
      :ref => "MyText",
      :abstract => "MyText",
      :link => "MyString",
      :type => ""
    ))
  end

  it "renders new admin_research form" do
    render

    assert_select "form[action=?][method=?]", admin_researches_path, "post" do

      assert_select "input#admin_research_title[name=?]", "admin_research[title]"

      assert_select "textarea#admin_research_ref[name=?]", "admin_research[ref]"

      assert_select "textarea#admin_research_abstract[name=?]", "admin_research[abstract]"

      assert_select "input#admin_research_link[name=?]", "admin_research[link]"

      assert_select "input#admin_research_type[name=?]", "admin_research[type]"
    end
  end
end
