class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def dashboard
    @documents = current_user.documents
    @rental = current_user.rentals.last
    @flat = @rental.flat
    @last_rents = @rental.rents.order("date DESC").first(3)
    @incident = Incident.new
    @incidents = current_user.rentals.last.flat.incidents.select { |incident| incident.date >= @rental.start_date }.order(DESC)
    @first_decision = Incident.first_decision
  end

  def dashboard2
    @documents = current_user.documents
    @rental = current_user.rentals.last
    @flat = @rental.flat
    @last_rents = @rental.rents.order("date DESC").first(3)
    @incident = Incident.new
    @incidents_all = current_user.rentals.last.flat.incidents
    if @incidents_all
      @incidents = @incidents_all.order("date DESC").select { |incident| incident.date >= @rental.start_date }
    else
      @incidents = []
    end
    @first_decision = Incident.first_decision
  end


end
