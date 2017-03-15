require 'rails_helper'

RSpec.describe Progress::Lo, type: :model do
  def attrs
    @teacher = FactoryGirl.create(:user_actived)
    @learner = FactoryGirl.create(:user_actived)
    @team = FactoryGirl.create(:team, user: @teacher, code: "1234")
    @lo = FactoryGirl.create(:lo, user: @teacher)
    @introduction1 = FactoryGirl.create(:introduction, lo: @lo)
    @introduction2 = FactoryGirl.create(:introduction, lo: @lo)
  end

  def create_exercise_question
    @exercise = FactoryGirl.create(:exercise, lo: @lo)
    @question1 = FactoryGirl.create(:question, exercise: @exercise, correct_answer: "6")
    @question2 = FactoryGirl.create(:question, exercise: @exercise, correct_answer: "10")
    @question3 = FactoryGirl.create(:question, exercise: @exercise, correct_answer: "5")
  end

  before do
    attrs

    @team.to_register? @learner, "1234"
    @team.register_lo @lo
    @progress = @team.create_lo_progress @lo, @learner

    @progress.previewed_an_introduction @introduction1
  end

  it "When viewing an introduction, it must be completed and add progress on the bars" do
    @progress.previewed_an_introduction @introduction1

    expect(@progress.progress_percent).to eq 0
    expect(@progress.preview_percent).to eq 50

    @progress.previewed_an_introduction @introduction2

    expect(@progress.progress_percent).to eq 0
    expect(@progress.preview_percent).to eq 100
  end

  it "When answering questions and miss them, you should only update the preview bar" do
    create_exercise_question

    @progress.previewed_an_introduction @introduction2

    @question1.answers.create!(team: @team, user: @learner, response: "2")
    @question2.answers.create!(team: @team, user: @learner, response: "10")

    @progress.recalc
    expect(@progress.progress_percent).to eq 33
    expect(@progress.preview_percent).to eq 89
  end

  it "When answering questions, you should update both bars" do
    create_exercise_question

    @progress.previewed_an_introduction @introduction2

    @question1.answers.create!(team: @team, user: @learner, response: "6")
    @question2.answers.create!(team: @team, user: @learner, response: "10")
    @question3.answers.create!(team: @team, user: @learner, response: "5")

    @progress.recalc
    expect(@progress.progress_percent).to eq 100
    expect(@progress.preview_percent).to eq 100
  end
end
