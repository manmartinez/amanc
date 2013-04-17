class Admin::UsersController < Admin::SharedController

  # GET /admin/users
  def index
    @users = User.admin.active.exclude(@current_user)  
  end
  
  # GET /admin/users/new(.:format)  
  def new
    @user = User.new
    gon.success_url = admin_users_url
  end
  
  # POST /admin/users.json
  def create
    password = params[:user].delete :password
    
    @user = User.new(params[:user])
    @user.user_type = User::TYPES[:admin]
    @user.password = password
    @user.save
    
    respond_to do |format|
      format.json { render :json => { :errors => @user.errors }}
    end
  end
  
  # GET /admin/users/:id/edit
  def edit
    @user = User.find(params[:id])
    gon.success_url = admin_users_url
  end
  
  # PUT /admin/users/:id
  def update
    password = params[:user].delete :password
    
    @user = User.find(params[:id])
    @user.password = password unless password.blank?
    @user.update_attributes(params[:user])
    
    respond_to do |format|
      format.json { render :json => { :errors => @user.errors }}
    end    
  end
  
  # DELETE /admin/users/:id
  def destroy
    @user = User.find(params[:id])
        
    respond_to do |format|
      format.json { render :json => { :deleted => @user.destroy } }
    end    
  end
end
