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
    post 'copy', on: :member
    resources :shares, only:[:new,:create] do
    end
    resources :tasks, only:[:new,:create] do
    # resources :tasks, only:[:create,:update] do
    end
    resources :reports, only:[:create,:index,:show] do
      get 'complete', on: :member
    end
  end
  resources :tasks, only:[:edit, :update, :destroy]
  resources :shares, except:[:new,:create] do
      resource :clips, only:[:create,:destroy]
  end
  resources :task_works, only:[:update]
  resources :clips, only:[:create,:destroy]
  resources :helps, only:[:index]

# ソート用
  patch 'goals/:id/sort', to: 'goals#sort'

  devise_for :users, :controllers => {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

end