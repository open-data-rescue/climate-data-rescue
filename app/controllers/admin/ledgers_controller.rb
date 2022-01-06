module Admin
  class LedgersController < AdminController
    # load_and_authorize_resource
    respond_to :html, :json, :js
    #Corresponds to the "ledger" model, ledger.rb. The functions defined below correspond with the various CRUD operations permitting the creation and modification of instances of the ledger model
    # All .html.slim views for "ledger.rb" are located at "project_root\app\views\ledgers"
    # GET /ledgers
    # GET /ledgers.json
    def index
      if current_user && current_user.admin?
        
        #@ledgers is the variable containing all instances of the "ledger.rb" model passed to the ledger view "index.html.slim" (project_root/ledgers) and is used to populate the page with information about each ledger using @ledgers.each (an iterative loop).
        @ledgers = Ledger.all
    
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @ledgers }
        end
      else
        flash[:danger] = 'Only administrators can modify ledgers! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # GET /ledgers/ledger_id
    # GET /ledgers/ledger_id.json
    def show
      if current_user
        #@ledger is a variable containing an instance of the "ledger.rb" model. It is passed to the ledger view "show.html.slim" (project_root/ledgers/ledger_id) and is used to populate the page with information about the ledger instance.
        @ledger = Ledger.includes(page_types: :pages).find(params[:id])
    
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @ledger }
        end
      else
        flash[:danger] = 'Only users can view ledgers! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # GET /ledgers/new
    # GET /ledgers/new.json
    def new
      if current_user && current_user.admin?
        @ledger = Ledger.new
        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @ledger }
        end
      else
        flash[:danger] = 'Only administrators can modify ledgers! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # GET /ledgers/ledger_id/edit
    def edit
      if current_user && current_user.admin?
        begin
          #@ledger is a variable containing an instance of the "ledger.rb" model. It is passed to the ledger view "edit.html.slim" (project_root/ledgers/edit) and is used to populate the page with information about the ledger instance. "edit.html.slim" loads the reusable form "_form.html.slim" which loads input fields to set the attributes of the curent ledger instance.
          @ledger = Ledger.find(params[:id])
        rescue => e
          flash[:danger] = e.message
        end
      else
        flash[:danger] = 'Only administrators can modify ledgers! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # POST /ledgers
    # POST /ledgers.json
    def create
      if current_user && current_user.admin?
        Ledger.transaction do
          begin
            #@ledger is a variable containing an instance of the "ledger.rb" model created with data passed in the params of the "new.html.slim" form submit action.
            @ledger = Ledger.create!(ledger_params)
          rescue => e
            flash[:danger] = e.message
          end
        end
    
        respond_to do |format|
          if @ledger && @ledger.id
            format.html { redirect_to [:admin, @ledger], success: 'Ledger was successfully created.' }
            format.json { render json: @ledger, status: :created, location: @ledger }
          else
            format.html { render action: "new" }
            format.json { render json: @ledger.errors, status: :unprocessable_ledger }
          end
        end
      else
        flash[:danger] = 'Only administrators can modify ledgers! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # PUT /ledgers/ledger_id
    # PUT /ledgers/ledger_id.json
    def update
      if current_user && current_user.admin?
        Ledger.transaction do
          begin
            #@ledger is a variable containing an instance of the "ledger.rb" model with attributes updated with data passed in the params of the "edit.html.slim" form submit action. 
            @ledger = Ledger.find(params[:id])
            @ledger.update!(ledger_params)
          rescue => e
            flash[:danger] = e.message
          end
        end

        respond_to do |format|
          if @ledger && @ledger.id
            format.html { redirect_to [:admin, @ledger], success: 'Ledger was successfully created.' }
            format.json { render json: @ledger, status: :created, location: @ledger }
          else
            format.html { render action: "edit" }
            format.json { render json: @ledger.errors, status: :unprocessable_ledger }
          end
        end
      else
        flash[:danger] = 'Only administrators can modify ledgers! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end

    # DELETE /ledgers/ledger_id
    # DELETE /ledgers/ledger_id.json
    def destroy
        #this function is called to delete the instance of "ledger.rb" identified by the ledger_id passed to the destroy function when it was called
      
      if current_user && current_user.admin?
        
        Ledger.transaction do
          begin
            @ledger = Ledger.find(params[:id])
            @ledger.destroy
          rescue => e
            # flash[:danger] = e.message
          end 
        end
        
        respond_to do |format|
          format.html { redirect_to ledgers_url }
          format.json { head :no_content }
        end
      else
        flash[:danger] = 'Only administrators can modify ledgers! <a href="' + new_user_session_path + '">Log in to continue.</a>'
        redirect_to root_path
      end
    end
    
    private
    def ledger_params
      params.require(:ledger).permit(:title, :ledger_type)
    end
  end
end