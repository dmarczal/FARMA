require 'rails_helper'

RSpec.describe ViewLo::LosHelper, type: :helper do

  it 'should be exec block' do
    list = [1, 2, 3, 4]
    command = false

    exec_if_the_page_exists(list, 2) do
      command = true
    end

    expect(command).to eq true
  end

  it 'should be not exec block' do
    list = [1, 2, 3, 4]
    command = false

    exec_if_the_page_exists(list, 0) do
      command = true
    end

    expect(command).to eq false
  end

  it 'should be not exec block' do
    list = [1, 2, 3, 4]
    command = false

    exec_if_the_page_exists(list, 5) do
      command = true
    end

    expect(command).to eq false
  end
end
