class WebmsController < ApplicationController
  add_breadcrumb "Home", '/'

  def index
    add_breadcrumb "Webms", '/webms'

    if params[:folder_name].nil?
      @webms = get_webms('general')
      @folder = 'general'
    else
      @webms = get_webms(params[:folder_name])
      @folder = params[:folder_name]
    end

    @webm_folders = []
    if File.directory?(Rails.root.join('public', 'webms'))
      Dir.entries(Rails.root.join('public', 'webms')).each do |folder|
        unless folder == '.' || folder == '..'
          @webm_folders << folder.downcase
        end
      end
    end

  end

  def get_webms(folder)
    if File.directory?(Rails.root.join('public', 'webms', folder, 'original'))
      webms = Dir.entries("public/webms/#{folder}/original")
      webms.delete('.')
      webms.delete('..')
      webms
    end
  end
end
