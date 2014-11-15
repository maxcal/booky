module OmniauthCredentialsHelper

  # @param options [Hash]
  # @return [Hash]
  def self.valid_credentials_hash(options = {})
    hash = {
        provider: 'facebook',
        uid: '1234567',
        info: {
            nickname: 'jbloggs',
            email: 'joe@bloggs.com',
            name: 'Joe Bloggs',
            first_name: 'Joe',
            last_name: 'Bloggs',
            image: 'http://graph.facebook.com/1234567/picture?type=square',
            urls: { Facebook: 'http://www.facebook.com/jbloggs' },
            location: 'Palo Alto, California',
            verified: true
        },
        credentials: {
            token: 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
            expires_at: 1321747205, # when the access token expires (it always will)
            expires: true # this will always be true
        }
    }

    hash[:info].merge(options)
    OmniAuth::AuthHash.new(hash)
  end

  # Sets a mock_auth with valid credentals
  # @param provider [Symbol]
  # @param hash [OmniAuth::AuthHash]
  # @return OmniAuth::AuthHash
  def self.valid_credentials!(provider, hash = OmniauthCredentialsHelper.valid_credentials_hash)
    # The mock_auth configuration allows you to set per-provider (or default) authentication
    # hashes to return during integration testing.
    OmniAuth.config.mock_auth[provider] = hash
    OmniAuth.config.mock_auth[provider]
  end

  # Sets a mock_auth with invalid credentials
  # @param provider [Symbol]
  # @return OmniAuth::AuthHash
  def self.invalid_credentials!(provider)
    OmniAuth.config.mock_auth[provider] = :invalid_credentials
    OmniAuth.config.mock_auth[provider]
  end

end