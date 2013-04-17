class Admin::TopicsController < Admin::SharedController

  # GET /admin/topics
  def index
    @topics = Topic.active.order('created_at DESC')
  end
  
  # GET /admin/topics/new(.:format)  
  def new
    @topic = Topic.new
  end
  
  # POST /admin/topics.json
  def create
    @topic = Topic.new(params[:topic])    
        
    respond_to do |format|      
      if @topic.save
        format.json { render :json => { :url => admin_topic_url(@topic) } }
      else
        format.json { render :json => { :errors => @topic.errors } }       
      end
    end
  end
  
  # GET /admin/topics/:id/edit
  def edit
    @topic = Topic.find(params[:id])
  end  
  
  # GET /admin/topics/:id
  def show
    @topic = Topic.active.find(params[:id])
  end
  
  # PUT /admin/topics/:id
  def update    
    @topic = Topic.active.find(params[:id])
    @topic.update_attributes(params[:topic])
    
    respond_to do |format|
      format.json { render :json => { :errors => @topic.errors, :url => admin_topic_url(@topic) }}
    end    
  end
  
  # DELETE /admin/topics/:id
  def destroy
    @topic = Topic.find(params[:id])
        
    respond_to do |format|
      format.json { render :json => { :deleted => @topic.destroy } }
    end    
  end

end
