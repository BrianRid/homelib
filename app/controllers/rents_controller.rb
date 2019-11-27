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

  def show
    @rent = Rent.find(params[:id])
    authorize @rent
    respond_to do |format|
      format.html { render :show }
      format.pdf {
        render :pdf => "show", :layout => 'pdf.html.erb'
      }
    end
  end

  # def quittance
  #   respond_to do |format|
  #     format.html { render :quittance }
  #     format.pdf {
  #       render :pdf => "quittance", :layout => 'pdf.html'
  #     }
  #   end
  # end

  private

  def rent_params
    params.require(:rent).permit(:status)
  end
end
