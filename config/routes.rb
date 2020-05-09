Rails.application.routes.draw do
  root to: 'pages#app'

  namespace :api do
    resources :feeds, except: %i[new edit]
    resources :articles, only: %i[index]
  end

  get '*path', to: 'pages#app', constraints: lambda { |req|
    %(/api).none? { |p| req.path.start_with?(p) }
  }
end
