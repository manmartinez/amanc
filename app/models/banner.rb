class Banner < ActiveRecord::Base
  include Attachable
    
  validates_presence_of :url, :sponsor_id
  
  after_create :create_assets_directory  
  before_destroy :delete_assets
  
  def self.random_banner
    self.all.shuffle.first
  end
  
  def self.assets_root
    File.join(Rails.root, 'public', 'system', 'banners')  
  end
  
  def image=(file)
    save_asset(:image, file)
  end
  
  def image_url
    asset_url(:image)
  end

  private
    def create_assets_directory
      FileUtils.mkdir_p self.asset_directory_for(:image)
    end
  
    def delete_assets
      delete_asset(:image)
      Dir.delete( self.asset_directory_for(:image) ) if Dir.exists? self.asset_directory_for(:image)
      Dir.delete( self.assets_root ) if Dir.exists? self.assets_root
    end
end
