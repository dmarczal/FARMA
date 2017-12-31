require 'rails_helper'

RSpec.describe Teacher::TeamService, type: :service do
  let(:user) { create(:user, :actived) }
  let(:los) { create_list(:lo, 5).map(&:id) }
  let(:team_los_params) { attributes_for(:team).merge({ los: los }) }
  let(:team_service) { Teacher::TeamService.new }

  it 'creates new team' do
    team_service.build_team(attributes_for(:team), user)

    expect(team_service.team).to be_is_a(Team)
  end

  it 'saves the team' do
    team_service.build_team(attributes_for(:team), user)

    expect(team_service.save_team).to be_truthy
  end

  it 'relates to los' do
    team_service.build_team(team_los_params, user)

    expect(team_service.save_team).to be_truthy
    expect(team_service.team.los).to_not be_empty
  end
end
