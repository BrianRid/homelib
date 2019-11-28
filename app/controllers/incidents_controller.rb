class IncidentsController < ApplicationController
  def new
    @incident = Incident.new
    authorize(@incident)
    @first_decision = Incident.first_decision
  end

  def create
    answer = params[:incident][:answer].to_sym
    @next_decision = Incident.next_decision(answer)
    if @next_decision.nil?
      @results = Incident.final_result(answer)
      @resume = Incident.resume(answer)
      render 'results'
      @incident = Incident.new
      authorize(@incident)
    else
      @incident = Incident.new
      authorize(@incident)
    end
  end
end
