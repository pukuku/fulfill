Rails.application.routes.draw do

  root 'homes#top'
  get 'about', to: 'homes#about'

  resource  :users, only:[:edit,:update] do
    get 'quit_confirm', on: :collection
    patch 'quit', on: :collection
  end

  resources :goals do
    get 'init', on: :collection
    post 'init_create', on: :collection
    resources :shares, only:[:new,:create]
    resources :tasks, only:[:create] do
    # resources :tasks, only:[:create,:update] do
      post 'copy', on: :collection
    end
    resources :reports, only:[:create,:index] do
      get 'complete', on: :collection
    end
  end
  resources :shares, except:[:new,:create]
  resources :tasks, only:[:edit, :update]
  resources :task_works, only:[:update]
  resources :clips, only:[:create,:destroy]
  resources :helps, only:[:index]

devise_for :users, controllers: { registrations: 'users/registrations' }

end