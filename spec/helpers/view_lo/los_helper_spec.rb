require 'rails_helper'

RSpec.describe ViewLo::LosHelper, type: :helper do
  let(:list) { [1, 2, 3, 4] }

  before { @command = false }

  it 'exec the block' do
    exec_if_the_page_exists(list, 2) do
      @command = true
    end

    expect(@command).to be_truthy
  end

  it 'does not exec the block' do
    exec_if_the_page_exists(list, 0) do
      @command = true
    end

    expect(@command).to be_falsey
  end

  it 'does not exec the block' do
    exec_if_the_page_exists(list, 5) do
      @command = true
    end

    expect(@command).to be_falsey
  end
end
