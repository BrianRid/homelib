class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def dashboard
    @rental = current_user.rentals.last
    @flat = @rental.flat
    @incident = Incident.new
    @last_rents = @rental.rents.order("date DESC").last(3)
  end
end
