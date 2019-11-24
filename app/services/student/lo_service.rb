class Student::LoService
  def initialize(team, user, lo, page)
    @team = team
    @user = user
    @contents = lo.contents
    @progress = lo.progress_lo(team)
    @content = @contents[page - 1]
    @page = page
  end

  def data
    {
      type: type,
      data: content,
      preview_percent: @progress&.preview_percent,
      progress_percent: @progress&.progress_percent,
      links: links
    }
  end

  private

  def content
    if @content.is_a? Introduction
      {
        position: @content.index,
        title: @content.title,
        content: @content.content
      }
    else
      {
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
          steps: content.link_steps(@team, @user),
          active: @page == page
        }
      end
    end
  end

  def steps
    @content.questions.map.with_index do |question|
      answers = question.answers.where(user_id: @user, team_id: @team).to_a
      last = answers.pop
      current = nil

      if last
        current = {
          value:      last.response,
          answer_tex: last.answer_tex,
          correct:    last.correct
        }
      end

      tips = question.tips_to_show({ user: @user, team: @team }) || []

      {
        position:  question.index,
        title:     question.title,
        content:   question.content,
        variables: question.variables,
        current: current,
        newTip: false,
        tips: tips.map { |tip| {
          id:              tip.id,
          number_of_tries: tip.number_of_tries,
          content:         tip.content
        }},
        responses: answers.map { |answer| {
          tips:      answer.response,
          tex:       answer.answer_tex,
          'Correto': answer.correct,
          'Data':    I18n.l(answer.created_at, format: :short)
        }}
      }
    end
  end

  def type
    return 'Introduction' if @content.is_a? Introduction
    'Exercise'
  end
end
