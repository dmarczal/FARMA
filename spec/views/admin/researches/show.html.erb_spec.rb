require 'rails_helper'

RSpec.describe "admin/researches/show", type: :view do
  before(:each) do
    @admin_research = assign(:admin_research, Admin::Research.create!(
      :title => "Title",
      :ref => "MyText",
      :abstract => "MyText",
      :link => "Link",
      :type => "Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Link/)
    expect(rendered).to match(/Type/)
  end
end
