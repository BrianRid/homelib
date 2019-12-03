class IncidentsController < ApplicationController
  def show
    @incident = Incident.find(params[:id])
    authorize(@incident)
    @resume = Incident.resume(@incident.last_answer)
    @category = Incident.category(@resume[0])
    # All workers in the specific category
    @workers = policy_scope(Worker).where(categories: @category)
    # Only the favorite ones
    @workers_favorite = current_user.rentals.last.flat.user.workers.where(categories: @category)
    @workers_other = @workers - @workers_favorite
  end

  def create
    answer = params[:incident][:answer].to_sym
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
      if @incident.save
        redirect_to incident_path(@incident)
      end
    end
  end

  def update
    @incident = Incident.find(params[:id])

    if @incident.update(incident_params, status: "Confirmé")
      @incident.update
      redirect_to restaurant_path(@incident)
    else
      render :edit
    end
  end

   def destroy
    @incident = Incident.find(params[:id])
    @incident.delete
    redirect_to dashboard_path
    end



  private

  def incident_params
    params.require(:incident).permit(:comment)
  end
end
