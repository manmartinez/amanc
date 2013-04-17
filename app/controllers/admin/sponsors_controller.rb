class Admin::SponsorsController < Admin::SharedController
  # GET /admin/sponsors
  def index
    @sponsors = Sponsor.active
  end
  
  # GET /admin/sponsors/new(.:format)  
  def new
    @sponsor = Sponsor.new
    gon.success_url = admin_sponsors_url
  end
  
  # POST /admin/sponsors.json
  def create
    credit = params[:sponsor].delete :credit
    @sponsor = Sponsor.new(params[:sponsor])
    @sponsor.credit = credit unless credit.blank?
    
    
    respond_to do |format|    
      if @sponsor.save
        format.json { render :json => { :url => admin_sponsor_url(@sponsor) } }       
      else    
        format.json { render :json => { :errors => @sponsor.errors } }       
      end
    end
  end
  
  # GET /admin/sponsors/:id/edit
  def edit
    @sponsor = Sponsor.find(params[:id])
    gon.success_url = admin_sponsors_url
  end
  
  # GET /admin/sponsors/:id/edit_logo
  def edit_logo
    @sponsor = Sponsor.find(params[:id])
  end
  
  # POST /admin/sponsors/:id/update_logo
  def update_logo
    @sponsor = Sponsor.find(params[:id])
    @sponsor.logo = params[:sponsor][:logo]
    
    if @sponsor.valid?
      redirect_to admin_sponsor_url(@sponsor)
    else
      render :edit_logo
    end    
  end
  
  # GET /admin/sponsors/:id
  def show
    @sponsor = Sponsor.active.find(params[:id])
  end
  
  # PUT /admin/sponsors/:id
  def update
    credit = params[:sponsor].delete :credit
    
    @sponsor = Sponsor.find(params[:id])
    @sponsor.credit = credit unless credit.blank?
    @sponsor.update_attributes(params[:sponsor])
    
    respond_to do |format|
      format.json { render :json => { :errors => @sponsor.errors, :url => admin_sponsor_url(@sponsor) }}
    end    
  end
  
  # DELETE /admin/sponsors/:id
  def destroy
    @sponsor = Sponsor.find(params[:id])
        
    respond_to do |format|
      format.json { render :json => { :deleted => @sponsor.destroy } }
    end    
  end

end
