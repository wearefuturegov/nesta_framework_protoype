class UsersController < ApplicationController
  
  def start_assessment
    user = User.find(params[:id])
    assessment = Assessment.create(user: user)
    redirect_to step_1_assessment_url(assessment)
  end

end
