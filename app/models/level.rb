class Level < ActiveRecord::Base
  has_many :questions
  belongs_to :topic
  
  before_create :assign_level
  
  validates_presence_of :level_number
  
  def name
    "Nivel #{self.level_number}"
  end
  
  private 
  
    def assign_level
      if self.topic.last_level
        self.level_number = self.topic.last_level.level_number + 1
      else
        self.level_number = 1
      end
    end
  
end
