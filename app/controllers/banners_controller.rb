class BannersController < ApplicationController
  def view
    @banner = Banner.find(params[:id])
    @banner.clicked!
    redirect_to @banner.url
  end
end
