class UploadsController < ApplicationController

  def new
  end

  def show
    @upload = current_user.uploads.find(params[:id])
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
    upload.save_file(file)
    send_file("tmp/#{file.name}")
  end

  def download_folder
    upload = Upload.new
    zipfile = "tmp/#{Time.now}.zip"
    files = current_user.folders.find(params[:id]).uploads
    upload.download_folder(files)
    send_file(zipfile)
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
