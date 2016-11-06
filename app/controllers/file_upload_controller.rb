class FileUploadController < ApplicationController
  add_breadcrumb "Home", '/'

  def index
    add_breadcrumb "File Upload", '/file_upload'
  end
end
