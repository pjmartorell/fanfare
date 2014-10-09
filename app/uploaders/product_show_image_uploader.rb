class ProductShowImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage APP_CONFIG["storage"].to_sym

  def store_dir
    "system/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fit => [630, 200]
end
