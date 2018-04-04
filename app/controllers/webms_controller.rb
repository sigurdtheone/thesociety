class WebmsController < ApplicationController
  add_breadcrumb "Home", '/'

  def index
    add_breadcrumb "Webms", '/webms'

    if params[:folder_name].nil?
      @images = get_webms('general')
      @folder = 'general'
    else
      @images = get_webms(params[:folder_name])
      @folder = params[:folder_name]
    end

    @image_folders = []
    if File.directory?(Rails.root.join('public', 'webms'))
      Dir.entries(Rails.root.join('public', 'webms')).each do |folder|
        unless folder == '.' || folder == '..'
          @image_folders << folder.downcase
        end
      end
    end

  end

  def get_images(folder)
    if File.directory?(Rails.root.join('public', 'webms', folder, 'original'))
      images = Dir.entries("public/images/#{folder}/original")
      images.delete('.')
      images.delete('..')
      images
    end
  end
end
