class FileUploadController < ApplicationController  
  http_basic_authenticate_with name: "sigurd", password: ENV['SIGURD_PASS']

  include Magick

  add_breadcrumb "Home", '/'

  def index
    add_breadcrumb "File Upload", '/file_upload'

    @image_folders = []
    @file_folders = []

    Dir.entries(Rails.root.join('public', 'images')).each do |folder|
      unless folder == '.' || folder == '..'
        @image_folders << folder.downcase
      end
    end

    Dir.entries(Rails.root.join('public', 'files')).each do |folder|
      unless folder == '.' || folder == '..'
        @file_folders << folder.downcase
      end
    end

    if params[:image_uploaded]
      @image_uploaded = params[:image_uploaded]
      @image_url ="images/#{params[:folder_name]}/original/#{params[:image_name]}"
    end

  end

  def upload
    uploaded_io = params[:file]
    folder_name = params[:folder_name]

    if uploaded_io.content_type.split('/')[0] == 'image'
      image_path = "#{images_folder(folder_name)}/original/#{uploaded_io.original_filename}"

      File.open(image_path, 'wb') do |file|
        file.write(uploaded_io.read)
      end

      img = Magick::Image::read(image_path)[0]
      img = img.resize_to_fill(100, 100, CenterGravity)
      img.write("#{images_folder(folder_name)}/thumbs/tmb_#{uploaded_io.original_filename}")

      redirect_to controller: 'file_upload', action: 'index', image_uploaded: true, folder_name: folder_name, image_name: uploaded_io.original_filename, notice: 'Image uploaded!'
    else
      file_path = "#{files_folder(folder_name)}/#{uploaded_io.original_filename}"

      File.open(file_path, 'wb') do |file|
        file.write(uploaded_io.read)
      end

      redirect_to controller: 'file_upload', action: 'index', image_uploaded: false, notice: 'File uploaded!'
    end
  end

  def create_folder
    folder_name = params[:folder_name]
    folder_type = params[:folder_type]

    if folder_type == 'image_folder'
      Dir.mkdir("#{images_folder(folder_name)}")
      Dir.mkdir("#{images_folder(folder_name)}/original")
      Dir.mkdir("#{images_folder(folder_name)}/thumbs")
    elsif folder_type == 'file_folder'
      Dir.mkdir("#{files_folder(folder_name)}")
    end

    redirect_to controller: 'file_upload', action: 'index', notice: "Folder: #{folder_name} created!"
  end

  def images_folder(folder_name)
    Rails.root.join('public', 'images', folder_name)
  end

  def files_folder(folder_name)
    Rails.root.join('public', 'files', folder_name)
  end

end
