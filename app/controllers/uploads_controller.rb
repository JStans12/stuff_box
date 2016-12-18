class UploadsController < ApplicationController
  def new
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
end
