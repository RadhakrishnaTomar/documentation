class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_client!

  def index
      @documents = current_user.super_admin? ? Document.all : Document.where(client_id: current_user.client&.id)
  end

  def new
    @document = Document.new
  end

  def create
    @document = current_user.client.documents.build(document_params)
    if @document.save
      redirect_to documents_path, notice: "Document uploaded successfully."
    else
      render :new
    end
  end

  private

  def ensure_client!
    redirect_to root_path, alert: "Access denied." unless current_user.client?
  end

  def document_params
    params.require(:document).permit(:title, :category, :file)
  end
end
