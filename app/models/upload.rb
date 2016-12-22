class Upload < ApplicationRecord
  attr_reader :s3
  belongs_to :folder

  has_many :comments

  def s3
    AWS::S3::Client.new(:access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'])
  end

  def save_file(file)
    name = file.name
    path = File.expand_path("~/Downloads")
    File.open("#{Rails.root}/tmp/#{name}", 'wb') do |file|
      s3.get_object({ bucket_name: 'stuff-box', key: name, target: "tmp/#{name}" }) do |chunk|
        file.write(chunk)
      end
    end
  end

  def download_folder(files)
    zipfile = "tmp/#{Time.now}.zip"
    files = files.each do |file|
      File.open("#{Rails.root}/tmp/#{file.name}", 'wb') do |files|
        s3.get_object({ bucket_name: 'stuff-box', key: file.name, response_target: "tmp/#{file.name}" }) do |chunk|
          files.write(chunk)
        end
      end
    end
    zip_folder(files, zipfile)
  end

  def zip_folder(files, zipfile)
    Zip::File.open(zipfile, Zip::File::CREATE) do |zip|
      files.each do |file|
        zip.add(file.name, "tmp/#{file.name}")
      end
    end
  end
end
