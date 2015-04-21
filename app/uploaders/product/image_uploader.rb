class Product::ImageUploader < BaseUploader

  storage :file

  process :auto_orient
  process :quality => 80
  process :resize_to_fit => [nil, 900]
  process :convert => 'jpeg'

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def store_dir
    "data/#{model.class.to_s.underscore.pluralize}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process :auto_orient
    process :quality => 80
    process :resize_to_limit => [600, 600]
    process :convert => 'jpeg'

    def full_filename(for_file = model.asset.file)
      ext = File.extname(for_file)
      base_name = for_file.chomp(ext)

      "#{base_name}_thumb.jpeg"
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end