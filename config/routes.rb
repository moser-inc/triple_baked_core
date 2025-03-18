Rails.application.routes.draw do
  namespace :admin do
    get 'login', to: 'user_sessions#new', as: 'login'
  end
end

# Not using isolated namespace
# TripleBakedCore::Engine.routes.draw do
# end
