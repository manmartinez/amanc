module Attachable
  def assets_root
    File.join(self.class.assets_root, self.id.to_s)
  end
  
  def asset_directory_for(asset_name)
    File.join(self.assets_root, asset_name.to_s)
  end
  
  def delete_asset(asset_name)    
    File.unlink(asset_path(asset_name)) if asset_path(asset_name) and File.exists? asset_path(asset_name)
  end
  
  def has_asset?(asset_name)
    !self.send("#{asset_name}_filename").nil?
  end  
    
  private
    def asset_url(asset_name)
      ['/system', self.class.name.downcase.pluralize, self.id, asset_name, self.send("#{asset_name}_filename")].join('/')
    end
    
    def asset_path(asset_name)
      File.join(self.asset_directory_for(asset_name), self.send("#{asset_name}_filename")) if self.has_asset?(asset_name)
    end
    
    def save_asset(asset_name, file)
      extension = File.extname(file.original_filename)
      self.send("#{asset_name}_filename=", "#{Time.now.to_i}#{extension}") if self.send("#{asset_name}_filename").nil?
      File.open(asset_path(asset_name), 'wb' ) do |asset_file|
          asset_file.write(file.tempfile.read)
      end
      self.save
    end
end
