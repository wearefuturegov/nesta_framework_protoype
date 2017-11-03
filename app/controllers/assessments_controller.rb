class AssessmentsController < ApplicationController
  before_action :get_areas, only: [:index, :new]
  
  def index
  end
  
  def new
  end
  
  def create
  end
  
  def update
  end
  
  def edit
  end
  
  def show
  end
  
  private
  
    def get_areas
      @areas = Area.all
    end
  
end
