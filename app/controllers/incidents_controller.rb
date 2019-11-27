class IncidentsController < ApplicationController
  def new
    @incident = Incident.new
    authorize(@incident)
    @first_decision = Incident.first_decision
  end

  def create
    answer = params[:incident][:answer].to_sym
    @next_decision = Incident.next_decision(answer)
    @incident = Incident.new
    authorize(@incident)
  end

  private

  def incident_params
  end
end
