class Admin::UserSessionsController < TbCore::ApplicationController
  # skip_before_action :require_admin_user
  layout 'admin/login'

  def new
    # if current_user
    #   redirect_to admin_root_path
    # elsif SpudUser.all.count.zero?
    #   logger.debug 'NO USERS!'
    #   redirect_to admin_setup_path and return
    # end
    # @user_session = SpudUserSession.new
  end
end