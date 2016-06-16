require 'rails_helper'

RSpec.describe Answer, type: :model do
  before do
    @user = FactoryGirl.create(:user_actived)
    @lo = FactoryGirl.create(:lo, user: @user)
    @exercise = FactoryGirl.create(:exercise, lo: @lo)
    @question = FactoryGirl.create(:question, exercise: @exercise , correct_answer: '8')
  end

  it 'equations should be equals' do
    answer = FactoryGirl.create(:answer, question: @question, response: '4 + 4')

    expect(answer.correct).to eq true
  end

  it 'equations should be not equals' do
    answer = FactoryGirl.create(:answer, question: @question, response: '2 + 1')

    expect(answer.correct).to eq false
  end

  it 'equations should be equals' do
    @question.correct_answer = "3;4"
    @question.save

    answer = FactoryGirl.create(:answer, question: @question, response: '4;3')

    expect(answer.correct).to eq true
  end

  it 'equations should be not equals' do
    @question.correct_answer = "3;4"
    @question.cmas_order = true
    @question.save

    answer = FactoryGirl.create(:answer, question: @question, response: '4;3')

    expect(answer.correct).to eq false
  end

  it 'equations should be equals' do
    @question.correct_answer = "4.651278"
    @question.precision = 4
    @question.save

    answer = FactoryGirl.create(:answer, question: @question, response: '4.6512')

    expect(answer.correct).to eq true
  end

  it 'equations should be not equals' do
    @question.correct_answer = "4.651278"
    @question.precision = 4
    @question.save

    answer = FactoryGirl.create(:answer, question: @question, response: '4.65')

    expect(answer.correct).to eq false
  end

end
