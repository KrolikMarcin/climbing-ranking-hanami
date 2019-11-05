root to: 'home#dashboard'
resources :sessions, only: %i[new create]
delete 'sessions', to: 'sessions#destroy', as: :session
