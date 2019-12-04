class DocumentsController < ApplicationController
  def new
    @document = Document.new
    authorize(@document)
  end

  def create
    @document = Document.new(documents_params)
    @document.user = current_user
    authorize(@document)

    if @document.save
      respond_to do |format|
        format.html { redirect_to dashboard_path }
        format.js
      end
    else
      # @flat =
      # @rental =

      render :new
    end
  end

  def destroy
    @document = Document.find(document_params[:id])
    @document.destroy
    authorize(@document)
    respond_to do |format|
      @notice = "Document successfully deleted"
      format.html do
        redirect_to dashboard_path, notice: @notice
      end
      format.js
    end
  end

  private

  def documents_params
    params.require(:document).permit(:name, :date, :file)
  end

  def document_params
    params.permit(:id)
  end
end
