require 'rails_helper'

RSpec.describe "admin/researches/edit", type: :view do
  before(:each) do
    @admin_research = assign(:admin_research, Admin::Research.create!(
      :title => "MyString",
      :ref => "MyText",
      :abstract => "MyText",
      :link => "MyString",
      :type => ""
    ))
  end

  it "renders the edit admin_research form" do
    render

    assert_select "form[action=?][method=?]", admin_research_path(@admin_research), "post" do

      assert_select "input#admin_research_title[name=?]", "admin_research[title]"

      assert_select "textarea#admin_research_ref[name=?]", "admin_research[ref]"

      assert_select "textarea#admin_research_abstract[name=?]", "admin_research[abstract]"

      assert_select "input#admin_research_link[name=?]", "admin_research[link]"

      assert_select "input#admin_research_type[name=?]", "admin_research[type]"
    end
  end
end
