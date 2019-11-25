class Student::LoTestService
  attr_accessor :tip_question

  def initialize(lo, page, answers)
    @answers = answers
    @contents = lo.contents
    @content = @contents[page - 1]
    @page = page
    @tip_question = nil
  end

  def data
    {
      type: type,
      data: content,
      preview_percent: nil,
      progress_percent: nil,
      links: links
    }
  end

  private

  def content
    if @content.is_a? Introduction
      {
        id: @content.id,
        position: @content.index,
        title: @content.title,
        content: @content.content
      }
    else
      {
        id: @content.id,
        position: @content.index,
        title: @content.title,
        content: @content.content,
        steps: steps
      }
    end
  end

  def links
    @contents.map.with_index do |content, index|
      page = index + 1
      if content.is_a? Introduction
        {
          id: "Introduction#{content.index}",
          position: content.index,
          type: 'Introduction',
          page: page,
          active: @page == page
        }
      else
        {
          id: "Exercise#{content.index}",
          position: content.index,
          type: 'Exercise',
          page: page,
          steps: content.link_test_steps(@answers),
          active: @page == page
        }
      end
    end
  end

  def steps
    @content.questions.map.with_index do |question|
      answers_aux = @answers[question.id.to_s] || []
      answers = answers_aux.clone
      last = answers.pop
      current = nil
      tries = 0
      tries = last['tries'] if !last.nil?

      if last
        current = {
          value:      last['value'],
          answer_tex: last['answer_tex'],
          correct:    last['correct']
        }
      end

      tips = []
      tips = question.tips_to_show({ tips_count: tries }) if tries > 0
      new_tip = tip_question.nil? && tip_question == question.id

      {
        id:        question.id,
        position:  question.index,
        title:     question.title,
        content:   question.content,
        variables: question.variables,
        current: current,
        newTip: new_tip,
        tips: tips.map { |tip| {
          id:              tip.id,
          number_of_tries: tip.number_of_tries,
          content:         tip.content
        }},
        responses: answers.map { |answer| {
          tex:       answer['answer_tex'],
          'Correto': answer['correct'] ? 'SIM' : 'NÃO',
        }}
      }
    end
  end

  def type
    return 'Introduction' if @content.is_a? Introduction
    'Exercise'
  end
end
