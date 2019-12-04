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
      redirect_to dashboard_path, notice: "Document successfully created"
    else
      render :new
    end
  end

  def destroy
    @document = Document.find(document_params[:id])
    @document.destroy
    authorize(@document)
    redirect_to dashboard_path, notice: "Document successfully deleted"
  end

  private

  def documents_params
    params.require(:document).permit(:name, :date, :file)
  end

  def document_params
    params.permit(:id)
  end
end
