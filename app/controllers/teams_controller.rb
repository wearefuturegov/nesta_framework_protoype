class TeamsController < ApplicationController
  
  def new
    @assessment = Assessment.find(params[:assessment_id])
    @team = Team.new(users: [
      @assessment.user
    ])
  end
  
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
