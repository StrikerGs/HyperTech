class ProfilesController < ApplicationController
  def new
    @profile = current_user
    
  end

  def create

     @profile = current_user
     

     if @profile.update(user_params)

      redirect_to root_path, notice: "Seus dados foram atualizados."

     else

      render :new

     end
  end

  private 

  def user_params

   params.require(:user).permit(:country, :adress,:cpf, :phone, :bank_account, role_ids: [])

  end
end
