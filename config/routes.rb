Rails.application.routes.draw do

  # メイン画面
  root 'homes#top'
  get 'about', to: 'homes#about'

  resources :goals do
    get 'init', on: :collection
    post 'init_create', on: :collection
    post 'copy', on: :member
    patch 'sort', on: :member
    resources :shares, only:[:new,:create]
    resources :tasks, only:[:new,:create,:edit,:update,:destroy]
    resources :reports, only:[:create,:index,:show] do
      get 'complete', on: :member
    end
  end

  resources :shares, except:[:new,:create] do
      resource :clips, only:[:create,:destroy]
  end

  resources :task_works, only:[:update]
  resources :helps, only:[:index]

  # ユーザー認証
  resource  :users, only:[:edit,:update] do
    get 'quit_confirm', on: :collection
    patch 'quit', on: :collection
  end

  devise_for :users, :controllers => {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

end