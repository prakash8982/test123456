class UserProfilesController < ApplicationController
  before_action :set_user_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!,expect: [:index]
  # GET /user_profiles
  # GET /user_profiles.json
  def index
    redirect_to pstaffs_path
  end

  # GET /user_profiles/1
  # GET /user_profiles/1.json
  def show
      @x  = @user_profile.user_id
       redirect_to pstaff_path(@x)
  end

  # GET /user_profiles/new
  def new
    # @user_profile = UserProfile.new
    if(current_user.phase1 == false &&  current_user.phase2 == false && current_user.phase3 == false)

      @user_profile = current_user.user_profiles.build
    else
       redirect_to new_user_session_path
    end
  end

  def temporary_staff

    if(current_user.phase1 == false &&  current_user.phase2 == false && current_user.phase3 == false)

      @user_profile = current_user.user_profiles.build
    else
      redirect_to new_user_session_path
    end

  end

  def scholars
    if(current_user.phase1 == false &&  current_user.phase2 == false && current_user.phase3 == false)

      @user_profile = current_user.user_profiles.build
    else
      redirect_to new_user_session_path
    end
  end

  def others
    if(current_user.phase1 == false &&  current_user.phase2 == false && current_user.phase3 == false)
      @user_profile = current_user.user_profiles.build
    else
      redirect_to new_user_session_path
    end
  end

  # GET /user_profiles/1/edit
  def edit
  end

  # POST /user_profiles
  # POST /user_profiles.json
  def create
    @user_profile = current_user.user_profiles.build(user_profile_params)

    respond_to do |format|
      if @user_profile.save
        format.html { redirect_to pstaffs_path, notice: 'User profile was successfully created.' }
        #format.json { render :show, status: :created, location: @user_profile }
      else
        format.html { render :new }
        format.json { render json: @user_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_profiles/1
  # PATCH/PUT /user_profiles/1.json
  def update
    respond_to do |format|
      if @user_profile.update(user_profile_params)
        format.html { redirect_to @user_profile, notice: 'User profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_profile }
      else
        format.html { render :edit }
        format.json { render json: @user_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_profiles/1
  # DELETE /user_profiles/1.json
  def destroy
    @user_profile.destroy
    respond_to do |format|
      format.html { redirect_to user_profiles_url, notice: 'User profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_profile
      @user_profile = UserProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_profile_params
      params.require(:user_profile).permit(:name, :unique_id, :gender, :mobile_no, :department, :applicant_type, :address,:id_proof,:photo)
    end
end
