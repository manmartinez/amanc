class PlayController < ApplicationController
  before_filter :get_current_player, :get_current_game
  
  def index
    @question = @game.next_question
    gon.next_question_url = play_next_question_url
  end


  def next_question
    @answer = Answer.find(params[:answer_id])    
    @game.evaluate_answer(@answer)
    @banner = Banner.random_banner
    respond_to do |format|
      format.json { 
                      render :json => { 
                        :next_question => @game.next_question.as_json(
                          :include => { :answers => { :only => [:id, :text] } },
                          :only => [:text]
                        ), 
                        :game => @game.as_json(
                          :include => {:level => {:only => [:level_number] } },
                          :methods => [ :closed? ]
                        ),
                        :banner => @banner.as_json(:methods => [:image_url])
                      } 
                  }
    end
  end
  
  protected
    def get_current_player
      @current_player = Player.find(session[:player_id]) unless session[:player_id].blank?
    end
    
    def get_current_game
      if session[:game_id]
        @game = Game.find(session[:game_id])        
      else
        start_game
      end      
    end
    
    def start_game
      @level = Topic.first.first_level
      @game = Game.new
      @game.player_id = @current_player.id unless @current_player.nil?        
      @game.current_level_id = @level.id
      @game.save
      session[:game_id] = @game.id
    end
end
