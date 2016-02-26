require 'rails_helper'

RSpec.describe Lo, type: :model do
  before :each do
    @lo = Lo.create!(name: Faker::Name.name, description: Faker::Name.title)
  end

  after do
    @lo.destroy
  end

  it "should not be stored in the table with null name" do
    @lo.name = nil
    expect(@lo.save).to eq false
  end

  it "should not be stored in the table with null description" do
    @lo.description = nil
    expect(@lo.save).to eq false
  end
end
