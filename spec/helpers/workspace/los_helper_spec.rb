require 'rails_helper'

# Specs in this file have access to a helper object that includes
RSpec.describe Workspace::LosHelper, type: :helper do

  it 'order of los items' do
    # user = FactoryGirl.create(:user_actived)
    # sing_in user
    lo = FactoryGirl.create(:lo)
    exercise1 = FactoryGirl.create(:exercise, lo: lo)
    introduction1 = FactoryGirl.create(:introduction, lo: lo)
    exercise2 = FactoryGirl.create(:exercise, lo: lo)
    introduction2 = FactoryGirl.create(:introduction, lo: lo)

    items = position_of_items lo

    expect(exercise1).to eq items[0]
    expect(introduction1).to eq items[1]
    expect(exercise2).to eq items[2]
    expect(introduction2).to eq items[3]

  end
end
