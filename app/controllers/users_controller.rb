class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "更新しました"
      redirect_to goals_path
    else
      render "edit"
    end
  end

  def quit_confirm
  end

  def quit
    @user = current_user
    @user.destroy
    reset_session # ログアウト
    flash[:notice] = "退会しました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :user_image)
  end
end
