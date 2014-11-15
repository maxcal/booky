# Handles return callbacks from OAuth provider
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # Use locale stored in session
  before_action :set_locale, except: [:localized]

  # Facebook redirects to this route after a successful authentication
  # @note Devise::Omniauth will handle unsuccessful attempts upstream, awesome!
  # @example
  #   GET|POST /users/auth/facebook/callback(.:format)
  def facebook
    handle_redirect('devise.facebook_data', 'Facebook')
  end

  # Adds locale to query params so that we can redirect to correct locale after auth
  # @example
  #   GET (/:locale)/user/omniauth/:provider(.:format)
  def localized
    redirect_to user_omniauth_authorize_path(params[:provider], locale: params[:locale])
  end

  private

  def handle_redirect(_session_variable, kind)
    sign_in_and_redirect User.from_omniauth_hash!(request.env["omniauth.auth"]), event: :authentication
    set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
  end

  # Sets the locale from the params returned by OAuth Provider
  def set_locale
    I18n.locale = request.env["omniauth.params"].try(:[], "locale") || I18n.default_locale
  end
end