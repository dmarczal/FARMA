require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'relationship' do
    it { is_expected.to belong_to(:exercise).counter_cache(true)}
    it { is_expected.to have_many(:tips).dependent(:destroy) }
    it { is_expected.to have_many(:answers).dependent(:destroy) }
    it { is_expected.to have_many(:tips_counts).dependent(:destroy) }
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of(:correct_answer) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:content) }
  end

  context 'Content completion' do
    subject { create(:question, correct_answer: '10') }

    let(:lo) { subject.exercise.lo }
    let!(:user) { subject.user }
    let(:team) { create(:team, user: user) }
    let(:student) { create(:user, :actived) }

    before do
      team.users << student
      team.los << lo
    end

    context "when it's incorrect answer" do
      context 'when has team' do
        before { subject.answers.create user_id: user.id, response: '5', team_id: team.id }

        it { is_expected.to be_visualized(team) }
        it { is_expected.to_not be_completed(team) }
        it { is_expected.to_not be_visualized }
        it { is_expected.to_not be_completed }
      end

      context 'when there is no team' do
        before { subject.answers.create user_id: user.id, response: '5' }

        it { is_expected.to_not be_visualized(team) }
        it { is_expected.to_not be_completed(team) }
        it { is_expected.to be_visualized }
        it { is_expected.to_not be_completed }
      end
    end

    context "when it's correct answer" do
      context 'when has team' do
        before { subject.answers.create user_id: user.id, response: '10', team_id: team.id }

        it { is_expected.to be_visualized(team) }
        it { is_expected.to be_completed(team) }
        it { is_expected.to_not be_visualized }
        it { is_expected.to_not be_completed }
      end

      context 'when there is no team' do
        before { subject.answers.create user_id: user.id, response: '10' }

        it { is_expected.to_not be_visualized(team) }
        it { is_expected.to_not be_completed(team) }
        it { is_expected.to be_visualized }
        it { is_expected.to be_completed }
      end
    end
  end
end
