class Upload < ApplicationRecord
  attr_reader :s3
  belongs_to :folder

  def s3
    AWS::S3.new(:access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'])
  end

  def bucket
    s3.buckets['stuff-box']
  end

  def save_file(file)
    path = File.expand_path("~/Downloads")
    temp_path = File.expand_path("~/temp")
    download = File.open("#{temp_path}/#{file}", 'wb').write(bucket.objects[file.name].read)
  end


end
