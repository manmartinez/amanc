class Sponsor < ActiveRecord::Base
  has_many :banners, :dependent => :destroy

  attr_protected :credit, :is_active  
  
  scope :active, where(:is_active => true)
  
  validates_presence_of :name, :credit, :url
  validates_numericality_of :credit
  
  after_create :create_assets_directory  
  before_destroy :delete_assets

  include Attachable
  
  def self.assets_root
    File.join(Rails.root, 'public', 'system', 'sponsors')
  end  
  
  def logo=(file)
    save_asset(:logo, file)
  end
  
  def logo_url
    self.has_asset?(:logo) ? asset_url(:logo) : self.class.default_logo_url
  end
  
  def self.default_logo_url
    ['/system', 'sponsors', 'logo', 'default.png'].join('/')
  end
  
  private
    def create_assets_directory
      FileUtils.mkdir_p self.asset_directory_for(:logo)
    end
  
    def delete_assets
      delete_asset(:logo)
      Dir.delete( self.asset_directory_for(:logo) ) if Dir.exists? self.asset_directory_for(:logo)
      Dir.delete( self.assets_root ) if Dir.exists? self.assets_root
    end
  
end
