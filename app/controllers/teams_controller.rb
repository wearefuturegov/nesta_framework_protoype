class TeamsController < ApplicationController
  
  def new
    @assessment = Assessment.find(params[:assessment_id])
    @team = Team.new(users: [
      @assessment.user
    ])
  end
  
  def create
    team = Team.create(team_params)
    redirect_to team_assessments_url(team), flash: { notice: I18n.t('teams.create.notice') }
  end
  
  private
  
    def team_params
      params.require(:team).permit(users_attributes: [
        :id, :email, :_destroy
      ])
    end

end
