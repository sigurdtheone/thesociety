Rails.application.routes.draw do
  # Root route
  root 'welcome#index'

  # File Upload
  get '/file_upload', to: 'file_upload#index'

  # Images
  get '/images', to: 'images#index'
  get '/images/:folder', to: 'images#index'
end
