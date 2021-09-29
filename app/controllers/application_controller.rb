class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]

  before_action :configure_permitted_parameters, if: :devise_controller?

  # サインイン後の遷移先を変更
  def after_sign_in_path_for(resource)
    goals_path
  end

  # サイドバーのユーザー情報
  def user_info
    @user = User.find(current_user.id)
    @clips = Clip.where(user_id: current_user.id).page(params[:page]).per(10)
  end

  # アクセス権
  def user_check(goal_user)
    if current_user.id != goal_user
      redirect_to goals_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_image])
  end
end
