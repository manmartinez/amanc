class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_sponsors
  protected
    def get_current_user
      @current_user = User.select([:id, :name, :surname, :user_type]).where(:id => session[:user_id]).first
    end
    
    def get_sponsors
      @sponsors = Sponsor.order(:name)
    end
end
