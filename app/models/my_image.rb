class MyImage < ApplicationRecord

	mount_uploader :image, ImageUploader

	paginates_per 4

  validates :name, uniqueness: true
  validate :presence_of_image

  def self.import(file)
  	response_hash = {}
	  imported_file = open_file(file)
	  header = imported_file.row(1)
	  if header.include?("name") and header.include?("url")
	  	response_hash = {success: 0, failed: 0, failed_rows: []}
		  (2..imported_file.last_row).each do |i|
		    row = Hash[[header, imported_file.row(i)].transpose]
		    image = MyImage.new(name: row["name"], remote_image_url: row["url"])
		    if image.save
		    	response_hash[:success] += 1
		    else
		    	response_hash[:failed] += 1
		    	response_hash[:failed_rows].push({"#{i.to_s}": image.errors.full_messages})
		    end
		  end
		else
			response_hash[:error_message] = "Import failed due to missing headers(e.g name, url)"
		end
	  response_hash
	end

	def self.open_file(file)
	  case File.extname(file.original_filename)
	  when ".csv" then Roo::CSV.new(file.path, csv_options: {encoding: "iso-8859-1:utf-8"})
	  else raise "Unknown file type: #{file.original_filename}"
	  end
	end

	private

	def presence_of_image
		if image.blank? and remote_image_url.blank?
			errors.add(:image, "has no file or url")
		end
	end
end
