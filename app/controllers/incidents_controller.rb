class IncidentsController < ApplicationController
  before_action :set_incident, only: [:show, :update, :destroy]

  def show
    @resume = Incident.resume(@incident.last_answer)
    @category = Incident.category(@resume[0])
    # All workers in the specific category
    @workers = policy_scope(Worker).where(categories: @category)
    # Only the favorite ones
    @workers_favorite = current_user.rentals.last.flat.user.workers.where(categories: @category)
    @workers_other = @workers - @workers_favorite
  end

  def create
    answer = incident_params[:answer].to_sym
    @next_decision = Incident.next_decision(answer)

    authorize(Incident.new)
    if @next_decision.nil?
      # creation incident
      @results = Incident.final_result(answer)
      @resume = Incident.resume(answer)
      @category = Incident.category(@resume[0])
      @flat = current_user.flat
      @incident = Incident.new(incident_params)
      @incident.tarif = @results[:final_answer][:tarif]
      @incident.responsable = @results[:final_answer][:responsable]
      @incident.reparation = @results[:final_answer][:result]
      @incident.flat = @flat
      @incident.category = @category
      @incident.last_answer = answer
      @incident.date = Date.today

      redirect_to incident_path(@incident) if @incident.save
    end
  end

  def update
    if @incident.update(incident_params.merge(status: "déclaré"))
      redirect_to dashboard_path, notice: "Incident créé avec succès"
    else
      render :edit
    end
  end

  def destroy
    @incident.delete
    redirect_to dashboard_path, notice: "Incident supprimé avec succès"
  end

  private

  def incident_params
    params.require(:incident).permit(:answer, :comment, :dispo, :date)
  end

  def set_incident
    @incident = Incident.find(params[:id])
    authorize(@incident)
  end
end
