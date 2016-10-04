module ViewLo::ApplicationHelper
  def previous_tip(team, question, tips, tip)
    if tips.length == 1
      return '<i class="material-icons medium grey-text">chevron_left</i>'.html_safe
    end

    if tips.first == tip
      return '<i class="material-icons medium grey-text">chevron_left</i>'.html_safe
    end

    index = tips.index(tip) - 1

    link_to '<i class="material-icons medium">chevron_left</i>'.html_safe,
            view_lo_tip_path(team, question, tips[index]),
            remote: true
  end

  def next_tip(team, question, tips, tip)
    if tips.length == 1
      return '<i class="material-icons medium grey-text right">chevron_right</i>'.html_safe
    end

    if tips.last == tip
      return '<i class="material-icons medium grey-text right">chevron_right</i>'.html_safe
    end

    index = tips.index(tip) + 1

    link_to '<i class="material-icons medium right">chevron_right</i>'.html_safe,
            view_lo_tip_path(team, question, tips[index]),
            remote: true
  end

  def current_tip(tips, tip)
    return "#{tips.index(tip) + 1}/#{tips.length}"
  end
end
