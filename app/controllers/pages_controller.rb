class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def dashboard
    @flat = current_user.rentals.last.flat
    @incident = Incident.new
  end
end
