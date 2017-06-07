class MyImage < ApplicationRecord

	mount_uploader :image, ImageUploader

	paginates_per 4

  validates :name, uniqueness: true

  # validate :validate_image_name_is_unique

  # private

  # def validate_image_name_is_unique
  #   if MyImage.exists?(image: image.file.original_filename)
  #     errors.add :image, "'#{image.file.original_filename}' already exists"
  #   end
  # end
end
