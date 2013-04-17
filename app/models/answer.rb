class Answer < ActiveRecord::Base
  belongs_to :question
  validates_presence_of :text, :question_id
  validate :only_one_correct_answer
  
  scope :exclude, lambda {|answer| where('id <> ?', answer.id) } 
  scope :correct, where(:is_correct => 1)
  
  def only_one_correct_answer
    if self.is_correct == 1
      self.errors.add(:is_correct, 'Solo puede haber una respuesta correcta') if self.question.answers.correct.exclude(self).count(:id) > 0
    end
  end  
  
  def correct?
    self.is_correct == 1
  end
end
