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
    upload = Upload.new
    file = Upload.find(params[:id])
    path = File.expand_path("~/Downloads")
    s3 = AWS::S3.new(:access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'])
    bucket = s3.buckets['stuff-box']
    download = File.open("#{Rails.root}/tmp/#{file.name}", 'wb').write(bucket.objects[file.name].read)
    send_data(download, filename: file.name)
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
