class ProfilesController < ApplicationController
  def new
    @profile = current_user
  end

  def create

     @profile = current_user
     
     if @profile.update(user_params)

      redirect_to root_path

     else

      render :new

     end
  end

  private 

  def user_params

   params.require(:user).permit(:country, :adress, :phone, :bank_account, role_ids: [])

  end
end
