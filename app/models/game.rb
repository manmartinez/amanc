class Game < ActiveRecord::Base
  STATUS = {
    :opened => 0,
    :closed => 1
  }


  belongs_to :level, :foreign_key => 'current_level_id'  
  has_many :game_answers
  has_many :answers, :through => :game_answers
  
  
  validates_presence_of :current_level_id
  
  def next_question 
    questions_answered = self.answers.select(:question_id).map { |q| q.question_id }
    next_question = nil
    if questions_answered.any?
      possible_questions = self.level.questions.where('id NOT IN (?)', questions_answered) 
      if possible_questions.any?  
        next_question = possible_questions.first
      else
        self.move_to_next_level!
        next_question = self.level(true).questions.first
      end
    else
      next_question = self.level.questions.first
    end
    next_question
  end
  
  def move_to_next_level!
    next_level = Level.where(:topic_id => self.level.topic_id, :level_number => self.level.level_number + 1).first
    if next_level
      self.current_level_id = next_level.id
    else
      self.close
    end
    self.save!
  end
  
  def evaluate_answer(answer)
    if answer.correct?
      self.answers << answer
      self.score += 10
    end
    self.save
  end
  
  def closed?
    self.status == STATUS[:closed]
  end
  
  def close
    self.status = STATUS[:closed]
  end
  

end
