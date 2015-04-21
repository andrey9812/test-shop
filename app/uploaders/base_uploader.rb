class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

protected

  def auto_orient
    manipulate! do |img|
      img.auto_orient
      img
    end
  end

  def quality(percentage, proc = nil)
    if proc.nil? || proc.call(self)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
  end

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end