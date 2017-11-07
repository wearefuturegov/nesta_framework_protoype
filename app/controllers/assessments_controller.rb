class AssessmentsController < ApplicationController
  before_action :get_areas
  prepend_before_action :get_assessment, only: [:edit, :show, :update]
  before_action :set_template, only: [:edit, :update]
  
  def index
    @step = 1
  end
  
  def new
    @step = 2
  end
  
  def create
    @assessment = Assessment.create
    redirect_to edit_assessment_url(@assessment)
  end
  
  def update
    # Update the assessment
    unless @assessment.update_attributes(assessment_params)
      flash[:error] = @assessment.errors.full_messages.to_sentence
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
      when 'strong_skills_added'
        @step = 4
        @template = 'weak_skills'
      when 'weak_skills_added'
        @step = 5
        @template = 'strong_attitudes'
      when 'strong_attitudes_added'
        @step = 6
        @template = 'weak_attitudes'
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
          :name, :email, :organisation_type, :position, :location
        ]
      )
    end
  
end
