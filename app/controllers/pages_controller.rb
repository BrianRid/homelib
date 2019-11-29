class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def dashboard
    @user = current_user
    @document = @current_user.documents
    @rental = current_user.rentals.last
    @flat = @rental.flat
    @last_rents = @rental.rents.order("date DESC").first(3)
    @incident = Incident.new
  end
end
