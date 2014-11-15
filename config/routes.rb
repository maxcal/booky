Rails.application.routes.draw do

  # omniauth_callbacks:auth_callbacks otherwise  does not work with scoped locales
  # see https://github.com/plataformatec/devise/issues/2813
  devise_for :users, skip: [:session, :password, :registration, :confirmation], controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  scope "(:locale)", locale: /en/ do
    devise_for :users, skip: :omniauth_callbacks
    root 'home#index'

    # === Custom error page handlers =================
    match '/404', to: 'errors#not_found', via: :all
    match '/422', to: 'errors#unprocessable_entity', via: :all
    match '/500', to: 'errors#internal_server_error', via: :all
  end

end
