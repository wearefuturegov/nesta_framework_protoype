class AssessmentsController < ApplicationController
  before_action :get_areas
  prepend_before_action :get_assessment, only: [:edit, :show, :update, :share]
  before_action :set_template, only: [:edit, :update]
  
  def index
    if params[:team_id]
      @team = Team.find(params[:team_id])
      @assessments = @team.assessments
      render 'team/assessments'
    else
      @step = 1
    end
  end
  
  def new
    @step = 2
  end
  
  def create
    @assessment = Assessment.create
    redirect_to edit_assessment_url(@assessment)
  end
  
  def update
    if params[:back]
      @assessment.go_back
    else
      # Update the assessment
      unless @assessment.update_attributes(assessment_params)
        flash[:error] = @assessment.errors.full_messages.to_sentence
      end
    end
    # Redirect to edit or show
    if @assessment.complete?
      redirect_to assessment_url(@assessment)
    else
      redirect_to edit_assessment_url(@assessment)
    end
  end
  
  def edit
    render "assessments/#{@template}"
  end
  
  def show
  end
  
  def share
    @team = Team.new(users: [
      @assessment.user
    ])
  end
  
  private
  
    def get_areas
      @areas = Area.all
    end
    
    def get_assessment
      @assessment = Assessment.find(params[:id])
    end
    
    def set_template
      case @assessment.aasm_state
      when 'start'
        @step = 3
        @template = 'strong_skills'
        @skills = Skill.all
      when 'strong_skills_added'
        @step = 4
        @template = 'weak_skills'
        @skills = Skill.where.not(id: @assessment.strong_skills)
      when 'weak_skills_added'
        @step = 5
        @template = 'strong_attitudes'
        @attitudes = Attitude.all
      when 'strong_attitudes_added'
        @step = 6
        @template = 'weak_attitudes'
        @attitudes = Attitude.where.not(id: @assessment.strong_attitudes)
      when 'weak_attitudes_added'
        @step = 7
        @template = 'user'
      end
    end
    
    def assessment_params
      params.require(:assessment).permit(
        strong_skills: [],
        weak_skills: [],
        strong_attitudes: [],
        weak_attitudes: [],
        user_attributes: [
          :id, :name, :email, :organisation_type, :position, :location
        ]
      )
    end
  
end
