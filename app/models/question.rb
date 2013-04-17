class Question < ActiveRecord::Base
  belongs_to :level
  belongs_to :topic
  has_many :answers

  validates_presence_of :text

end
