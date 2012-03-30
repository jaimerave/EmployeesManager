class UsersController < ApplicationController
  #before_filter :authenticate_user!
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to user_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end
end