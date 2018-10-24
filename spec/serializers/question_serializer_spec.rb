require 'rails_helper'

RSpec.describe QuestionSerializer, type: :serializer do
  let(:question) {build_stubbed(:question)}
  let(:serializer) {described_class.new(question)}
  let(:serialization) {ActiveModelSerializers::Adapter.create(serializer)}

  subject { serialization.serializable_hash }

  it { is_expected.to include(id:             question.id) }
  it { is_expected.to include(title:          question.title) }
  it { is_expected.to include(position:       question.position) }
  it { is_expected.to include(content:        question.content) }
  it { is_expected.to include(correct_answer: question.correct_answer) }
  it { is_expected.to include(precision:      question.precision) }
  it { is_expected.to include(exercise_id:    question.exercise_id) }
  it { is_expected.not_to include(created_at: question.created_at) }
  it { is_expected.not_to include(updated_at: question.updated_at) }
end
