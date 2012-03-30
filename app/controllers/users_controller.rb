class UsersController < ApplicationController
  #before_filter :authenticate_user!
  def show
    @user = User.first
  end

  def edit
    @user = User.first
  end

  def update
    @user = User.first
    if @user.update_attributes(params[:user])
      redirect_to user_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end
end