class Player < ActiveRecord::Base
  belongs_to :user
  
  def name
    self.user.name
  end
  
  def surname 
    self.user.surname
  end
  
  def email
    self.user.email
  end

end
