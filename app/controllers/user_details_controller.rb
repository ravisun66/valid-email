class UserDetailsController < ApplicationController

  def index
    @user_detail = UserDetail.new
    @valid_emails = UserEmail.all
  end

  def create
    @user_detail = UserDetail.new(user_detail_params)
    if @user_detail.save
      valid_email = @user_detail.valid_email_found?
      if valid_email[:valid]
        user_email = @user_detail.build_user_email(email: valid_email[:email])
        user_email.save
        return redirect_to user_details_path, notice: 'Email added successfully.'
      else
        return redirect_to user_details_path, notice: 'Valid email not found'
      end
    else
      @valid_emails = UserEmail.all
      flash.now[:notice] = @user_detail.errors.full_messages.join(',')
      render :index
    end
  end

  private
  def user_detail_params
    params.require(:user_detail).permit(:first_name, :last_name, :url)
  end
end
