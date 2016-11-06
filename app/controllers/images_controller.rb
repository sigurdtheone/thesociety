class ImagesController < ApplicationController
  add_breadcrumb "Home", '/'

  def index
    add_breadcrumb "Images", '/images'

    if params[:folder].nil?
      @images = get_images('general')
      @folder = 'general'
    else
      @images = get_images(params[:folder])
      @folder = params[:folder]
    end

  end

  def get_images(folder)
    images = Dir.entries("public/images/#{folder}/original")
    images.delete('.')
    images.delete('..')
    images
  end
end
