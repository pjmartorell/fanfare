class ProductImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage APP_CONFIG["storage"].to_sym

  def store_dir
    "system/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize => ["300x160"]
  version :small do
    process :resize => ["180x96"]
  end

  def resize(size)
    manipulate! do |img|
      img.resize "#{size}!"
      img
    end
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
