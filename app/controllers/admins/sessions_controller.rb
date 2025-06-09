# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    # 継承元のDeviseの処理をそのまま実行する
    super
  end

  # POST /resource/sign_in
  def create
    # ログインが成功したら、継承元のDeviseのcreateを実行後、sessionに値を保存する
    super
    session[:admin_id] = current_admin.id
  end

  # DELETE /resource/sign_out
  def destroy
    # ログアウトしたら、sessionの値を削除後、継承元のdeviseのdestroyを実行する
    session.delete(:admin_id)
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
