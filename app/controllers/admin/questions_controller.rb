class Admin::QuestionsController < Admin::SharedController

  def new
    @level = Level.find(params[:level_id])
    @question = @level.questions.build
  end
  
  def create 
    @level = Level.find(params[:level_id])
    @question = @level.questions.build(params[:question])
    @question.topic = @level.topic
    
    respond_to do |format|
      if @question.save
        format.json { render :json => { :url => admin_level_question_url(@level, @question) } }
      else
        format.json { render :json => { :errors => @question.errors } }
      end
    end
  end
  
  def show
    @level = Level.find(params[:level_id])
    @question = @level.questions.find(params[:id])
  end
  
  def edit
    @level = Level.find(params[:level_id])
    @question = @level.questions.find(params[:id])
  end
  
  def update
    @level = Level.find(params[:level_id])
    @question = @level.questions.find(params[:id])
    
    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.json { render :json => { :url => admin_level_question_url(@level, @question) } }
      else
        format.json { render :json => { :errors => @question.errors } }
      end
    end
  end
  
  def destroy
    @level = Level.find(params[:level_id])
    @question = @level.questions.find(params[:id])
    
    respond_to do |format|
      format.json { render :json => {:deleted => @question.destroy} }
    end
  end

end
