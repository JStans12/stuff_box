class UploadsController < ApplicationController

  def new
  end

  def show
    @upload = current_user.uploads.find(params[:id])
    @comment = Comment.new
    @upload_comments = @upload.comments
  end

   def create
    if params[:file]
      obj = S3_BUCKET.objects[params[:file].original_filename]

      obj.write(
        file: params[:file],
        acl: :public_read
      )

      @upload = Upload.new(
          url: obj.public_url,
          name: obj.key,
          folder_id: session[:current_folder_id]
      )

      if @upload.save
        redirect_to root_path, success: 'File successfully uploaded'
      else
       flash[:danger] = 'There was an error'
        redirect_to root_path
      end
    else
      flash[:danger] = 'Attach a file'
      redirect_to root_path
    end
   end

  def index
    @uploads = Upload.all
  end

  def download
    file = Upload.find(params[:id])
    name = file.name
    path = File.expand_path("~/Downloads")
    s3 = AWS::S3::Client.new(:access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'])
    download = File.open("#{Rails.root}/tmp/#{name}", 'wb') do |file|
      s3.get_object({ bucket_name: ':stuff-box', key: name, target: "tmp/#{name}" }) do |chunk|
        file.write(chunk)
      end
    end
    send_file("tmp/#{name}")
  end

  def destroy
    file = Upload.find(params[:format])
    if file.folder.owner == current_user
      file.destroy
      redirect_to root_path, success: 'Folder is deleted'
    else
      redirect_to root_path, danger: 'Do not have permission'
    end
  end
end
