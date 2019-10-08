require 'rails_helper'

RSpec.describe QuestionSerializer, type: :serializer do
  let(:question) {build_stubbed(:question)}
  let(:serializer) {described_class.new(question)}
  let(:serialization) {ActiveModelSerializers::Adapter.create(serializer)}

  subject { serialization.serializable_hash }

  it { is_expected.to include(id:             question.id) }
  it { is_expected.to include(title:          question.title) }
  it { is_expected.to include(variables:       question.variables) }
  it { is_expected.to include(content:        question.content) }
  it { is_expected.to include(correct_answer: question.correct_answer) }
  it { is_expected.to include(answer_tex:      question.answer_tex) }
  it { is_expected.to include(precision:      question.precision) }
end
