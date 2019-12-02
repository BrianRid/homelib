class RentsController < ApplicationController
  # update a rent when click paid button
  def update
    @rent = Rent.find(params[:id])
    authorize @rent
    if @rent.update(rent_params)
      respond_to do |format|
        format.html { redirect_to dashboard_path }
        format.js  # <-- will render `app/views/rents/update.js.erb`
      end
    else
      respond_to do |format|
        format.html { render "pages/dashboard" }
        format.js  # <-- idem
      end
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

  private

  def rent_params
    params.require(:rent).permit(:status)
  end
end
