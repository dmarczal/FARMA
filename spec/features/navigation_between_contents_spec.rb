require 'rails_helper'

RSpec.feature "NavigationBetweenContents", type: :feature do
  include FormHelpers

  let!(:teacher) { create(:user_actived) }
  let!(:student) { create(:user_actived) }
  let!(:lo) { create(:lo, user: teacher) }
  let!(:introduction1) { create(:introduction, lo: lo) }
  let!(:exercise1) { create(:exercise, lo: lo) }
  let!(:introduction2) { create(:introduction, lo: lo) }
  let!(:exercise2) { create(:exercise, lo: lo) }
  let!(:exercise3) { create(:exercise, lo: lo) }
  let!(:team) { create(:team, user: teacher) }
  let(:introduction_icon) { 'text_format' }
  let(:exercise_icon) { 'format_list_bulleted' }

  describe 'sidebar' do
    let(:contents) { lo.contents }

    before do
      sing_in student
      student.register id: team.id, code: team.code
      team.los_teams.create(lo_id: lo.id)
      set_positions

      visit student_team_lo_path(team, lo)
    end

    it 'Should include the quantity of contents' do
      expect(page.all('.list li').size).to eq contents.size
    end

    it 'Should list the introductions and exercises in order' do
      contents = lo.contents
      index = 0

      page.all('.list li').each do |content|
        icon = contents[index].is_a?(Exercise) ? exercise_icon : introduction_icon
        index += 1

        expect(content).to have_content(icon)
        expect(page).to have_link(nil, href: student_team_lo_path(team, lo, page: index + 1))
      end
    end

  end

  def set_positions
    introduction1.position = 1.second.from_now.to_i
    introduction1.save
    exercise1.position = 2.second.from_now.to_i
    exercise1.save
    introduction2.position = 3.second.from_now.to_i
    introduction2.save
    exercise2.position = 4.second.from_now.to_i
    exercise2.save
    exercise3.position = 5.second.from_now.to_i
    exercise3.save
  end

end
