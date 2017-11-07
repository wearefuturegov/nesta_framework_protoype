class AssessmentsController < ApplicationController
  before_action :get_areas
  prepend_before_action :get_assessment, only: [:edit, :show, :update]
  before_action :set_template, only: [:edit]
  
  def index
  end
  
  def new
  end
  
  def create
    @assessment = Assessment.create
    redirect_to edit_assessment_url(@assessment)
  end
  
  def update
    # Update the assessment
    @assessment.update_attributes(assessment_params)
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
        @template = 'strong_skills'
      when 'strong_skills_added'
        @template = 'weak_skills'
      when 'weak_skills_added'
        @template = 'strong_attitudes'
      when 'strong_attitudes_added'
        @template = 'weak_attitudes'
      when 'weak_attitudes_added'
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
          :name, :email, :organisation_type, :position, :location
        ]
      )
    end
  
end
