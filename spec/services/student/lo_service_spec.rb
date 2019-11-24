require 'rails_helper'

RSpec.describe Student::LoService do
  let(:user) { create(:user, :actived) }
  let(:lo) do
    current_lo = create(:lo)
    exercise_1 = create(:exercise, lo: current_lo)
    create(:introduction, lo: current_lo)
    exercise_2 = create(:exercise, lo: current_lo)
    create(:introduction, lo: current_lo)

    create(:question, correct_answer: '10', exercise: exercise_1)
    create(:question, correct_answer: '2', exercise: exercise_2)
    create(:question, correct_answer: '5', exercise: exercise_2)
    current_lo
  end
  let(:team) { create(:team, lo: lo) }
  let(:contents) { lo.contents }

  before { user.teams << team }

  it 'returns page 3' do
    content = contents[2]
    service = Student::LoService.new team, user, lo, 3

    data = {
      position: content.index,
      title: content.title,
      content: content.content
    }

    links = contents.map.with_index do |content, index|
      page = index + 1
      if content.is_a? Introduction
        {
          id: "Introduction#{content.index}",
          position: content.index,
          type: 'Introduction',
          page: page,
          active: 3 == page
        }
      else
        {
          id: "Exercise#{content.index}",
          position: content.index,
          type: 'Exercise',
          page: page,
          steps: content.link_steps(@team, @user),
          active: 3 == page
        }
      end
    end

    expect(service.data[:data]).to eq data
    expect(service.data[:type]).to eq 'Introduction'
    expect(service.data[:links]).to eq links
  end

  it 'returns page 1' do
    content = contents[0]
    Answer.create question: content.questions.first, team: team, user: user, response: '2', answer_tex: '2'
    Answer.create question: content.questions.first, team: team, user: user, response: '10', answer_tex: '10'
    service = Student::LoService.new team, user, lo, 1

    steps = content.questions.map.with_index do |question|
      answers = question.answers.where(user_id: user, team_id: team).to_a
      last = answers.pop
      current = nil
      if last
        current = {
          value:      last.response,
          answer_tex: last.answer_tex,
          correct:    last.correct
        }
      end

      {
        position:  question.index,
        title:     question.title,
        content:   question.content,
        variables: question.variables,
        current: current,
        responses: answers.map { |answer| {
          value:      answer.response,
          answer_tex: answer.answer_tex,
          correct:    answer.correct
        }}
      }
    end

    data = {
      position: content.index,
      title: content.title,
      content: content.content,
      steps: steps
    }

    expect(service.data[:data]).to eq data
    expect(service.data[:type]).to eq 'Exercise'
  end

  it 'returns responses into links' do
    content = contents[1]
    Answer.create question: content.questions.first, team: team, user: user, response: '2', answer_tex: '2'
    service = Student::LoService.new team, user, contents, 2

    link = {
      id: "Exercise#{content.index}",
      position: content.index,
      type: 'Exercise',
      page: 2,
      steps: [true, nil],
      active: true
    }

    expect(service.data[:links][1]).to eq link
  end
end
