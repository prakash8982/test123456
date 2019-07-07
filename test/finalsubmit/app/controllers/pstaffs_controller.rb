class PstaffsController < ApplicationController
 before_action :set_pstaff, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!,expect: [:index]
  # GET /pstaffs
  # GET /pstaffs.json
  def index
    if(current_user.phase1 == false &&  current_user.phase2 == false && current_user.phase3 == false)
      x= current_user.id
      @user_profile = UserProfile.all.where("user_id = ?",x)
      @user_profile =@user_profile[0]
     #puts(@user_profile[0].department)

      @pstaff = Pstaff.where("user_profile_id = ?",@user_profile.id)

    else
      redirect_to  new_user_session_path
    end
  end
  # GET /pstaffs/1
  # GET /pstaffs/1.json
  def show
     redirect_to pstaffs_path
    # @pstaffs = Pstaff.find(params[:id])
    #
    # if current_user.id != @pstaffs.user_profile_id
    #   flash[:notice] = "You don't have access to that order!"
    #   redirect_to pstaffs_path(session[:current_user])
    # return
    # end
  end
  #for user
  def showuser
    @pstaff=Pstaff.find(params[:id])
    @user_profile = UserProfile.find(@pstaff.user_profile_id)
    
  end
  # GET /pstaffs/new
  

  def new
    if(current_user.phase1 == false &&  current_user.phase2 == false && current_user.phase3 == false)
      x= current_user.id
      @user_profile = UserProfile.all.where("user_id = ?",x)
      @user_profile =@user_profile[0]
      @pstaff = @user_profile.pstaffs.build
    else
       redirect_to new_user_session_path
    end
  end

  # GET /pstaffs/1/edit
  def edit
    if(current_user.phase1 == false &&  current_user.phase2 == false && current_user.phase3 == false)
     # @pstaff = current_user.pstaffs.build
    else
       redirect_to new_user_session_path
    end
  end

  def tstaff_new
    if(current_user.phase1 == false &&  current_user.phase2 == false && current_user.phase3 == false)
      @pstaff = current_user.pstaffs.build
    else
       redirect_to new_user_session_path
    end
    
  end

  def phdstaff_new
     if(current_user.phase1 == false &&  current_user.phase2 == false && current_user.phase3 == false)
      @pstaff = current_user.pstaffs.build
    else
       redirect_to new_user_session_path
    end
    
  end

  def vender_new
    if(current_user.phase1 == false &&  current_user.phase2 == false && current_user.phase3 == false)
      @pstaff = current_user.pstaffs.build
    else
       redirect_to new_user_session_path
    end
    
  end

  def others_new
     if(current_user.phase1 == false &&  current_user.phase2 == false && current_user.phase3 == false)
      @pstaff = current_user.pstaffs.build
    else
       redirect_to new_user_session_path
    end
    
  end

  # POST /pstaffs
  # POST /pstaffs.json
  def create
    x= current_user.id
    @user_profile = UserProfile.all.where("user_id = ?",x)
    @user_profile =@user_profile[0]
    @pstaff = @user_profile.pstaffs.build(pstaff_params)

    respond_to do |format|
      if @pstaff.save
        x= true
        @id = User.all.where("phase1 = ?",x)
        NotifyMailer.with(user: @id[0]).recive_email.deliver
        format.html { redirect_to @pstaff, notice: 'Pstaff was successfully created.' }
        format.json { render :user, status: :created, location: @pstaff }
      else
        format.html { render :new }
        format.json { render json: @pstaff.errors, status: :unprocessable_entity }
      end
    end
  end



  # PATCH/PUT /pstaffs/1
  # PATCH/PUT /pstaffs/1.json
  def update

    respond_to do |format|
      if @pstaff.update(pstaff_params)
        x=true
        @id = User.all.where("phase1 = ?",x)

        NotifyMailer.with(user: @id[0]).recive_email.deliver

        format.html { redirect_to @pstaff, notice: 'Pstaff was successfully updated.' }
        format.json { render :show, status: :ok, location: @pstaff }
      else
        format.html { render :edit }
        format.json { render json: @pstaff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pstaffs/1
  # DELETE /pstaffs/1.json
  def destroy
    @pstaff.destroy
    respond_to do |format|
      format.html { redirect_to pstaffs_url, notice: 'Pstaff was successfully destroyed.' }
      format.json { head :no_content }
    end
   end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pstaff
      # if(current_user.phase1 == false &&  current_user.phase2 == false && current_user.phase3 == false)
      @pstaff = Pstaff.find(params[:id])
    # else
    #    redirect_to new_user_session_path
    # end
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pstaff_params
      params.require(:pstaff).permit(:vichel_no, :vichel_model, :vehical_type,:registration_certificate, :document, :RC_holder_name, :relationship)
    end
end
