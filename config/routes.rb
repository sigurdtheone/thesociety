Rails.application.routes.draw do
  # Root route
  root 'welcome#index'

  # File Upload
  get '/file_upload', to: 'file_upload#index'
  post '/file_upload/upload', to: 'file_upload#upload'
  post '/file_upload/create_folder', to: 'file_upload#create_folder'

  # Images
  get '/images', to: 'images#index'
  post '/images', to: 'images#index'
end
