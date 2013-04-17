class Topic < ActiveRecord::Base
  has_many :levels
  has_many :questions

  scope :active, where(:is_active => true)
  
  validates_presence_of :name
  
  def first_level
    @first_level ||= self.levels.order('level_number').limit(1).first
  end
  
  def last_level
    @last_level ||= self.levels.order('level_number DESC').limit(1).first
  end
end
