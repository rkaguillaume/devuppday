Rails.application.routes.draw do

  root 'pages#home'

  devise_for :users,
              path: '',
              path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
              controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}

    resources :users, only: [:show]
    resources :rooms, except: [:edit] do
      member do
        get 'listing'
        get 'pricing'
        get 'description'
        get 'photo_upload'
        get 'pdf_upload'
        get 'event'
        get 'equipment'
        get 'location'
        get 'preload'
        get 'preview'
      end
      resources :photos, only:  [:create, :destroy]
      resources :reservations, only: [:create]
      resources :calendars
      resources :pdfs, only:  [:create, :destroy]
    end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :guest_reviews, only: [:create, :destroy]
  resources :host_reviews, only: [:create, :destroy]

  get '/your_booking' => 'reservations#your_booking'
  get '/your_reservations' => 'reservations#your_reservations'

  get 'search' => 'pages#search'
  get 'uppday' => 'pages#uppday'
  get 'project' => 'pages#project'
  get 'services' => 'pages#services'


# ----- Dashboards ------
  get 'dashboard' => 'dashboards#index'

  resources :reservations, only: [:approve, :decline] do
    member do
      post '/approve' => "reservations#approve"
      post '/decline' => "reservations#decline"
    end
  end

  resources :revenues, only: [:index]

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end

  get 'host_calendar' => "calendars#host"

  get '/notifications' => 'notifications#index'

  mount ActionCable.server => '/cable'

end
