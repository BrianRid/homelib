class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def dashboard
    @documents = current_user.documents
    @rental = current_user.rentals.last
    @flat = @rental.flat
    @last_rents = @rental.rents.order("date DESC").first(3)
    @incident = Incident.new
    @incidents = current_user.incidents
    @first_decision = Incident.first_decision
  end
end
