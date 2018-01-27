Henlo.setup do |config|

  ## All expiration claims use seconds as unit

  ## Refresh token expiration claim
  ## ----------------
  ##
  ## How long before a refresh token is expired. If nil is provided, token will
  ## last forever.
  ##
  ## Default is 15 days
  # config.refresh_token_lifetime = 15 * 86400

  ## Id token expiration claim
  ## ----------------
  ##
  ## How long before an id token is expired. If nil is provided, token will
  ## last forever.
  ## This value is provided in seconds
  ## Default is 15 minutes
  # config.id_token_lifetime = 60 * 15
  
end