Rails.application.routes.draw do
  scope "api/v1" do
    devise_for :clients
  end
  namespace "api" do
    namespace "v1" do
      resources :customers, only:[:create, :update]
      resources :transactions, only: :create
      resources :rewards, only: :index
    end
  end
end
