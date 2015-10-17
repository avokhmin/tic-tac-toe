Rails.application.routes.draw do

  ############################################################
  #
  # A P I   V E R S I O N   1 +
  #
  ############################################################

  apipie
  namespace :api do
    namespace :v1, constraints: { format: 'json' }, defaults: { format: 'json' } do
      resources :games, only: [:index, :show] do
        member do
          put '/tic/:row/:column' => 'games#tic'
        end
      end
    end
  end

  root 'games#index'

  resources :games, only: %i(index new create show)
end
