class Admin::AnswersController < Admin::SharedController
  
  def new
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build
  end
  
  def create 
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(params[:answer])
    
    respond_to do |format|
      if @answer.save
        format.json { render :json => { :url => admin_level_question_url(@question.level, @question) } }
      else
        format.json { render :json => { :errors => @answer.errors } }
      end
    end
  end
  
  def edit
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
  end
  
  def update
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    
    respond_to do |format|
      if @answer.update_attributes(params[:answer])
         format.json { render :json => { :url => admin_level_question_url(@question.level, @question) } }
      else
        format.json { render :json => { :errors => @answer.errors } }
      end
    end
  end
  
  def destroy
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    
    respond_to do |format|
      format.json { render :json => {:deleted => @answer.destroy} }
    end
  end

  
end
