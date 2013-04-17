class Admin::SharedController < ApplicationController
  layout 'admin'
  before_filter :require_admin_session
  
  protected
    def require_admin_session 
      get_current_user
      unless @current_user and @current_user.admin?
        flash[:notice] = 'Por favor inicia sesi&oacute;n'
        redirect_to login_url
      end
    end
end
