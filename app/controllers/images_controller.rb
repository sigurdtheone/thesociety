class ImagesController < ApplicationController
  add_breadcrumb "Home", '/'

  def index
    add_breadcrumb "Images", '/images'

    if params[:folder_name].nil?
      @images = get_images('general')
      @folder = 'general'
    else
      @images = get_images(params[:folder_name])
      @folder = params[:folder_name]
    end

    @image_folders = []
    Dir.entries(Rails.root.join('public', 'images')).each do |folder|
      unless folder == '.' || folder == '..'
        @image_folders << folder.downcase
      end
    end

  end

  def get_images(folder)
    images = Dir.entries("public/images/#{folder}/original")
    images.delete('.')
    images.delete('..')
    images
  end
end
