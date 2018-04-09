require 'rails_helper'

RSpec.describe Admin::Developer, type: :model do
  let(:developer) { create(:developer) }
  let(:admin) { create(:admin) }

  context 'validate fields' do
  	it 'raise a RecordInvalid error' do 
  		dev = Admin::Developer.new

  		expect{ dev.save }.to raise_error(ActiveRecord::RecordInvalid)
  	end
  end

end
