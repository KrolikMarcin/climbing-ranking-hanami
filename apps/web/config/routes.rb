root to: 'home#dashboard'
resources :sessions, only: %i[new create]
delete 'sessions', to: 'sessions#destroy', as: :session
resources :users, except: %i[index destroy]
resources :ascents, only: %i[new create show]
