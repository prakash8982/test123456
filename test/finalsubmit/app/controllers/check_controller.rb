class CheckController < ApplicationController
  skip_before_action :verify_authenticity_token,:only =>[:sticker,:remark]
  before_action :authenticate_user!,expect: [:show,:index]
	def phase1
        if current_user.phase1 == true
            @phases= Pstaff.where("disapprove = false AND phase1 = false", params[:pstaffs], false)
        else
            redirect_to new_user_session_path
        end

  end

  def phase2
    if current_user.phase2 == true
      @phases= Pstaff.where("disapprove = false AND phase1 = true AND phase2 = false", params[:pstaffs], false)
    else
      redirect_to new_user_session_path
    end
  end

    def phase3
        if current_user.phase3 == true
          @phases= Pstaff.where("disapprove = false AND phase2 = true AND phase3 = false", params[:pstaffs], false)
          @phases1= Pstaff.where("disapprove = false AND phase2 = true AND phase3 = true", params[:pstaffs], false)
        else
            redirect_to new_user_session_path
        end
    end

    def admin
      @phases= Pstaff.all
    end

    def remark
        @current_user = current_user
        @remark=Pstaff.find(params[:id])
        if params[:commit]=='Submit'
            if current_user.phase1 == true
                x=Pstaff.find(@remark.id)
                x.phase1=true
                x.phase1_remark=pstaff_params[:phase1_remark]


                @user = User.all
                for i in @user do
                  if(i.role == x.department)
                    @id = i
                    break
                  end
                end
                x.save

                NotifyMailer.with(user: @id).recive_email.deliver


                #@p = User.find(z)
                # NotificationMailer.with(user:@p).approve_email.deliver
                flash[:notice] = "approved succesfully!"
                redirect_to check_phase1_path
            elsif current_user.phase2 == true
                user=Pstaff.find(@remark.id)
                user.phase2_remark=pstaff_params[:phase2_remark]
                user.phase2=true
                @user = User.all
                for i in @user do
                  if(i.phase3 == true)
                    @id = i
                    break
                  end
                end
                user.save
                NotifyMailer.with(user: @id).recive_email.deliver

                flash[:notice] = "approved succesfully!"
                redirect_to check_phase2_path

            elsif current_user.phase3 == true
                @user=Pstaff.find(@remark.id)
                @user.phase3=true
                @user.sticker=pstaff_params[:sticker]
                @user.save
                p = UserProfile.find(@user.user_profile_id)
                @p = User.find(p.user_id)
                NotificationMailer.with(user:@p).approve_email.deliver
                flash[:notice] = "approved succesfully!"
                redirect_to check_phase3_path()
            else
        end
   
            
        end
    end



   def show_user_form
       @pstaff=Pstaff.find(params[:id])
       @user_profile = UserProfile.find(@pstaff.user_profile_id)
        #redirect_to pstaff_path(@pstaff)
       end
  def approve
    if current_user.phase1 == true
    
    	  x=Pstaff.find(params[:id])
        x.phase1=true
        x.save
        userprofile = UserProfile.find(x.user_profile_id)
        @p= User.all.where("phase2= ? AND role=?",true,userprofile.department)
        NotifyMailer.with(user:@p[0]).recive_email.deliver
         flash[:notice] = "approved succesfully!"
         redirect_to check_phase1_path
    
    elsif current_user.phase2 == true
    	user=Pstaff.find(params[:id])
        user.phase2=true
        user.save
        #userprofile = UserProfile.find(user.user_profile_id)
        @p= User.all.where("phase3= ?",true)
        NotifyMailer.with(user:@p[0]).recive_email.deliver
        flash[:notice] = "approved succesfully!"
        redirect_to check_phase2_path
    
    elsif current_user.phase3 == true
    
    	@user=Pstaff.find(params[:id])
        @user.phase3=true
        @user.save
        flash[:notice] = "approved succesfully!"
        redirect_to check_phase3_path()
    else
    end
    end

    def disapprove

        if current_user.phase1 == true
        
        x=Pstaff.find(params[:id])
        x.disapprove= true
        x.save
        z = x.user_profile_id
        z = UserProfile.find(z)
        @z = User.find(z.user_id)
         NotificationMailer.with(user:@z).disapprove_email.deliver
        flash[:notice] = "application disapprove succesfully"

        redirect_to check_phase1_path
    elsif current_user.phase2 == true
        user=Pstaff.find(params[:id])
        user.disapprove = true
        user.save
        z = user.user_profile_id
        z = UserProfile.find(z)
        @z = User.find(z.user_id)
        NotificationMailer.with(user:@z).disapprove_email.deliver
        flash[:notice] = "application disapprove succesfully"

        redirect_to check_phase2_path
    elsif current_user.phase3 == true

        @user=Pstaff.find(params[:id])

        @user.disapprove =true
        @user.save
        flash[:notice] = "application disapprove succesfully"
        redirect_to check_phase3_path
    else
    end
        
    end
    

    def pstaff_params
        params.require(:pstaff).permit(:sticker,:vichel_no,:phase1_remark,:phase2_remark,:phase3_remark)
    end


  # def sticker
  #      @sticker=Pstaff.find(params[:id])
  #      if params[:commit]=='Submit'
  #
  #      if current_user.phase3 == true
  #        @user=Pstaff.find(@sticker.id)
  #        @user.phase3=true
  #        @user.sticker=pstaff_params[:sticker]
  #        @user.save
  #      end
  #      end
  # end

end
