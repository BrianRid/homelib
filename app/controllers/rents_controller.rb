class RentsController < ApplicationController
  # update a rent when click paid button
  def update
    @rent = Rent.find(params[:id])
    authorize @rent
    if @rent.update(rent_params)
      redirect_to dashboard_path
    else
      render "pages/dashboard"
    end
  end

  private

  def rent_params
    params.require(:rent).permit(:status)
  end
end
