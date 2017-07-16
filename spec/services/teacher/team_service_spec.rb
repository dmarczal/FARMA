require 'rails_helper'

RSpec.describe Teacher::TeamService, type: :service do
  let!(:user) { create(:user_actived) }
  let!(:los) do
    los_objs = create_list(:lo, 5)
    los_ids = []

    los_objs.each do |lo|
      los_ids << lo.id
    end

    los_ids
  end

  it 'should create a new team' do
    team_service = Teacher::TeamService.new
    team_service.build_team(attributes_for(:team), user)

    expect(team_service.team).to_not eq nil
  end

  it 'should save the team' do
    team_service = Teacher::TeamService.new
    team_service.build_team(attributes_for(:team), user)

    expect(team_service.save_team).to eq true
    expect(team_service.team.id).to_not eq nil
  end

  it 'should relate to objects' do
    team_service = Teacher::TeamService.new
    attrs = attributes_for(:team)
    attrs[:los] = los
    team_service.build_team(attrs, user)

    expect(team_service.save_team).to eq true
    expect(team_service.team.los).to_not eq []
  end

end
