require 'rails_helper'

RSpec.describe QuestionSerializer, type: :serializer do
  let(:question) {FactoryBot.build(:question)}
  let(:serializer) {described_class.new(question)}
  let(:serialization) {ActiveModelSerializers::Adapter.create(serializer)}

  let(:subject) {JSON.parse(serialization.to_json)}

  it 'has an id that matches' do
    expect(subject['id']).to eql(question.id)
  end

  it 'has a name that matches' do
    expect(subject['title']).to eql(question.title)
  end

  it 'has a position that matches' do
    expect(subject['position']).to eql(question.position)
  end

  it 'has a content that matches' do
    expect(subject['content']).to eql(question.content)
  end

  it 'has a correct answer that matches' do
    expect(subject['correct_answer']).to eql(question.correct_answer)
  end

  it 'has a precision that matches' do
    expect(subject['precision']).to eql(question.precision)
  end
end