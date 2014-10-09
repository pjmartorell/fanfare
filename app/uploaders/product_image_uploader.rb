class ProductImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage APP_CONFIG["storage"].to_sym

  def store_dir
    "system/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fit => [300, 160]
  version :small do
    process :resize_to_fit => [180, 96]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
