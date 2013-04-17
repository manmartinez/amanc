class Admin::BannersController < Admin::SharedController
  
  # GET /admin/sponsors/:sponsor_id/banners/new
  def new
    @sponsor = Sponsor.find(params[:sponsor_id])
    @banner = @sponsor.banners.build
  end
  
  # POST /admin/sponsors/:sponsor_id/banners
  def create 
    @sponsor = Sponsor.find(params[:sponsor_id])
    
    image = params[:banner].delete :image
    @banner = @sponsor.banners.build(params[:banner])
    
    if @banner.save
      @banner.image = image 
      
      if @banner.valid?
        redirect_to admin_sponsor_url(@sponsor)
      else
        render :new
      end
    end
    
  end
  
  # DELETE /admin/sponsors/:sponsor_id/banners/:id
  def destroy
    @sponsor = Sponsor.find(params[:sponsor_id])
    @banner = @sponsor.banners.find(params[:id])
    
    respond_to do |format|
      format.json { render :json => { :deleted => @banner.destroy }}
    end
  end

end
