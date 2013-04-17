class User < ActiveRecord::Base 

  SALT = '4m4nC!'
  TYPES = {   
    :admin    => 0,
    :player   => 1
  }
  
  attr_protected :encrypted_password, :password, :user_type
  
  scope :active, where(:is_active => 1)
  scope :exclude, lambda { |user| where('users.id <> ?', user.id) }
  scope :admin, where(:user_type => TYPES[:admin])
  
  has_one :player
  
  validates_presence_of [:name, :surname, :email, :encrypted_password]
  validates_confirmation_of :password, :if => :needs_password?
  validates_length_of :password, :minimum => 6, :if => :needs_password?
  validate :email_is_unique
  
  # True if user is admin
  def admin?
    self.user_type == TYPES[:admin]
  end

  # Returns a user with corresponding email and password or nil
  def self.authenticate(email, pwd)
    user = self.active.where(:email => email).first
    if user
      user = nil unless user.encrypted_password.eql? self.encrypt(pwd, SALT)
    end
    user
  end
  
  # True if user needs to assign a password
  def needs_password?
    self.new_record? || !self.password.blank?
  end
  
  # Returns the full_name of the user
  def full_name
    "#{self.name} #{self.surname}"
  end
  
  def change_password(current_password, new_password)
    if self.class.encrypt(current_password, SALT).eql? self.encrypted_password
      self.password = new_password
      self.save
    else
      errors.add(:current_password, "no coincide con el password actual")
      false
    end
  end
  
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    self.encrypted_password = self.class.encrypt(pwd,SALT) unless pwd.blank?
  end  
  
  protected
    def self.encrypt(*args)      
      Digest::SHA1.hexdigest(args.join)
    end
    
    # Validates that the email is unique per active users
    def email_is_unique
      active_users = User.active.where(:email => self.email)
      active_users = active_users.exclude(self) unless self.new_record?
      errors.add :email, 'ya existe' if active_users.count(:id) > 0
    end

end
