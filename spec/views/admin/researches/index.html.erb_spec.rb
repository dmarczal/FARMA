require 'rails_helper'

RSpec.describe "admin/researches/index", type: :view do
  before(:each) do
    assign(:admin_researches, [
      Admin::Research.create!(
        :title => "Title",
        :ref => "MyText",
        :abstract => "MyText",
        :link => "Link",
        :type => "Type"
      ),
      Admin::Research.create!(
        :title => "Title",
        :ref => "MyText",
        :abstract => "MyText",
        :link => "Link",
        :type => "Type"
      )
    ])
  end

  it "renders a list of admin/researches" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Link".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
  end
end
