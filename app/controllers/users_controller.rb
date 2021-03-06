class UsersController < ApplicationController
  before_action  :set_user, :finish_signup

   def index
     @users = User.find.all
   end

  def finish_signup
    if request.patch? && params[:user] #&& params[:user][:email]
      if current_user.update(user_params)
        current_user.skip_reconfirmation!
        sign_in(current_user, :bypass => true)
        redirect_to root_path, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def show
      @user = User.find(params[:id])
    end

    def user_params
      accessible = [ :name, :email, :image ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible, :name, :image)
      #params.require(:user).permit(:name, :image)
    end

end