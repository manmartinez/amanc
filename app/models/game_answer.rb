class GameAnswer < ActiveRecord::Base
  belongs_to :game
  belongs_to :answer
  
  validates_uniqueness_of :answer_id, :scope => :game_id
end
