class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  process resize_to_fill: [400, 400]

  version :small do
    process resize_to_fill: [50,50]
  end

  def store_dir
    "system/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "/tmp/#{model.class.to_s.underscore}/#{model.id}"
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path("assets/shared/" + [version_name, "default-user-avatar.jpeg"].compact.join('-'))
  end

  def content_type_whitelist
    /image\//
  end
end
