class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_client!, only: [:new, :create] 
  before_action :restrict_manager_access, only: [:index, :show, :edit, :update]
  before_action :restrict_supervisor_from_editing_documents, only: [:new, :create, :edit, :update]



  def index
    @documents = current_user.super_admin? ? Document.all : Document.where(client_id: current_user.client&.id)
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = Document.new
  end

  def create
    if current_user.client?
      client = Client.find_by(user_id: current_user.id)
      unless client
        redirect_to root_path, alert: "Client not found." and return
      end
      @document = client.documents.build(document_params)
      if @document.save
        redirect_to documents_path, notice: "Document uploaded successfully."
      else
        render :new, status: :unprocessable_entity
      end
    else
      # Handle for other roles if needed
      redirect_to root_path, alert: "You are not authorized to upload documents."
    end
  end

  
  def edit
    @document = Document.find(params[:id])
  end
  
 def update
   @document = Document.find(params[:id])
   if @document.update(document_params)
     redirect_to @document, notice: "Document was successfully updated."
   else
     render :edit
   end
 end

 def update_category
   @document = Document.find(params[:id])
   if @document.update(category: params[:document][:category])
     redirect_to dashboard_path, notice: "Category updated successfully."
   else
     redirect_to dashboard_path, alert: "Failed to update category."
   end
 end

  private

  def ensure_client!
    return if current_user.super_admin? 
    redirect_to root_path, alert: "Access denied." unless current_user.client?
  end

  def restrict_manager_access
    if current_user.manager?
      redirect_to root_path, alert: "Access denied. Managers cannot view documents."
    end
  end

  def restrict_supervisor_from_editing_documents
    if current_user.supervisor?
      redirect_to dashboard_path, alert: "You are not authorized to modify documents."
    end
  end


  def document_params
    params.require(:document).permit(:title, :category, :file)
  end
end
