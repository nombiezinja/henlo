Henlo.setup do |config|

  ## Refresh token expiration claim
  ## ----------------
  ##
  ## How long before a refresh token is expired. If nil is provided, token will
  ## last forever.
  ##
  ## Default:
  # config.refresh_token_lifetime = 15.days

  ## Id token expiration claim
  ## ----------------
  ##
  ## How long before an id token is expired. If nil is provided, token will
  ## last forever.
  ## This value is provided in seconds
  ## Default is 15 minutes
  # config.id_token_lifetime = 60 * 15

end