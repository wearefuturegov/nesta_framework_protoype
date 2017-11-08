class TeamsController < ApplicationController

  def create
    team = Team.create
    team.update_attributes(team_params)
  end
  
  private
  
    def team_params
      params.require(:team).permit(users_attributes: [
        :id, :email, :_destroy
      ])
    end

end
