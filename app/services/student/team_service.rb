class Student::TeamService
  attr_accessor :team

  def initialize(team = nil)
    @team = team
  end

  def self.build_json_teams(teams, user, form_authenticity_token)
    json_teams = []

    teams.each do |team|
      json_teams << self.to_json(team, user)
    end

    {teams: json_teams, token: form_authenticity_token}
  end

  private

  def self.to_json(team, user)
    {
      id: team.id,
      name: team.name,
      userName: team.user.name,
      userImage: team.user.avatar.url,
      createdAt: I18n.l(team.created_at, :format => :short),
      registered: user.registered?(team)
    }
  end
end
