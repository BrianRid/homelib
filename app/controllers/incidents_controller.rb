class IncidentsController < ApplicationController
  def new
    # @incident = Incident.new
    # authorize(@incident)
    # @first_decision = Incident.first_decision
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

      # All workers in the specific category
      @workers = policy_scope(Worker).where(categories: @category)
      # Only the favorite ones
      @workers_favorite = current_user.rentals.last.flat.user.workers.where(categories: @category)
      @workers_other = @workers - @workers_favorite
      render ‘results’

      @incident = Incident.new(incident_params)
      @incident.tarif = @results[:final_answer][:tarif]
      @incident.responsable = @results[:final_answer][:responsable]
      @incident.reparation = @results[:final_answer][:result]

    if @incident.save
      redirect_to @show
    end
    # else
    #   @incident = Incident.new
    #   authorize(@incident)
    end
  end

  private

 def incident_params
    params.require(:incident).permit(:comment)
  end
end
