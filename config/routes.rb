EmployeesManager::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  resource :user, only: [:edit, :show]

  root :to => 'admin/dashboard#index'
end
