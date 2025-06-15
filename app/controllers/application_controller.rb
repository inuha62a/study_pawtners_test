class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    # ユーザー登録時にnameのストロングパラメータを追加（サインアップ時にnameを入力する場合は追記）
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    # ユーザー編集時にnameとprofileのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :profile ])
  end
end
