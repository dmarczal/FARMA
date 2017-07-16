class Teacher::TeamService
  attr_accessor :team

  def initialize(team = nil)
    @team = team
  end

  def build_team(team_attrs, user)
    @los = team_attrs.delete(:los)
    @team = user.my_teams.new team_attrs
  end

  def save_team
    @team.opened = true

    return false unless @team.save
    relate_to_los unless @los.nil?

    true
  end

  private

  def relate_to_los
    @los.each do |lo|
      @team.register_lo(lo) if Lo.exists?(lo)
    end
  end
end
