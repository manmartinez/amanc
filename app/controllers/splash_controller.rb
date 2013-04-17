class SplashController < ApplicationController

  def index
    
  end  
  
  def play
  
  end
  
  def logout
    reset_session
    flash[:notice] = 'Tu sesi&oacute;n ha terminado'
    redirect_to root_url
  end
  
  def login
    render :layout => 'login'
  end
  
  def authenticate
    @user = User.authenticate(params[:login][:email], params[:login][:password])
    if @user
      session[:user_id] = @user.id
      redirect_to admin_root_url
    else
      flash[:notice] = 'Usuario / Contrase&ntilde;a inv&aacute;lida'
      render :login, :layout => 'login'
    end
  end
  
end
