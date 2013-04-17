class Admin::LevelsController < Admin::SharedController

  def create    
    @topic = Topic.find(params[:topic_id])
    @level = @topic.levels.build        
        
    respond_to do |format|
      if @level.save
        format.json { render :json => {:url => admin_topic_url(@topic) } }
      else
        format.json { render :json => { :errors => @level.errors }, :status => :unprocessable_entity }
      end      
    end
  end
  
  def show
    @level = Level.find(params[:id])
  end
  
  def destroy
    @level = Level.find(params[:id])
    
    respond_to do |format|
      format.json { render :json => {:deleted => @level.destroy } }  
    end
  end

end
