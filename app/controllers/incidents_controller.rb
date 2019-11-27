class IncidentsController < ApplicationController
  def create
    @flat = Flat.find(params[:flat_id])
    @incident = Incident.new(incident_params)
    @incident.flat = @flat
    authorize @incident
    if @incident.save
      respond_to do |format|
        format.html { render 'incidents/feu' }
        # format.js { render 'incidents/feu' } # <-- will render `app/views/incidents/feu.js.erb`
        format.js # <-- will render `app/views/incidents/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'pages/dashboard' }
        format.js # <-- idem
      end
    end
  end

  private

  def incident_params
    params.require(:incident).permit(:category)
  end
end
