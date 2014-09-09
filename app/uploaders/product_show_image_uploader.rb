class ProductShowImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage APP_CONFIG["storage"].to_sym

  def store_dir
    "system/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize => ["630x200"]

  def resize(size)
    manipulate! do |img|
      img.resize "#{size}!"
      img
    end
  end
end
