module Admin
  class DataEntriesAuditDetailController < AdminController
    
    def index
      @audits = Views::DataEntriesAuditDetail.all
    end
    
    def show
      @audit = Views::DataEntriesAuditDetail.find(params[:id])
      
      respond_to do |format|
        format.html
      end
    end
    
    def edit
      @audit = Views::DataEntriesAuditDetail.find(params[:id])
    end
    
    def update
      Audit::DataEntryVersion.transaction do
        begin
          audit = Audit::DataEntryVersion.find(params[:id])
        
          audit.update(audit_params)
          flash[:success] = 'Entry successfully updated'
        rescue => e
          flash[:danger] = e.message
        end
        
        respond_to do |format|
          format.html { redirect_to admin_data_entries_audit_detail_path }
        end
      end
    end
    
    private
    
    def audit_params
      params.require(:views_data_entries_audit_detail).permit(:notes)
    end
    
  end

end