# Henlo

Henlo is an opionated token-based authentication based on the gem Knock. Henlo offers an additional layer of token security by exposing methods for implementing the use of refresh tokens and id tokens. 

For a beginning introduction to refresh token and id tokens, here is an article: 
https://auth0.com/blog/refresh-tokens-what-are-they-and-when-to-use-them/

Essentially, a refresh token with a long expiry time (weeks or months) is used to renew a short expiry time token, the id token. The id token is used to access resources when users make requests, and the refresh token is solely used to renew id tokens. This structure allows limiting the damage done by breached tokens. Refresh tokens can be blacklisted and revoked, whereas id tokens are only valid for a short period of time. 

## Installation

Add this line to your application's Gemfile:

    $ gem 'henlo', :git => 'git://github.com/nombiezinja/henlo.git', :branch => 'master'

And then execute:

    $ bundle

To install Henlo and create a blank initializer file:

    $ rails g henlo:install

To generate migration files for the model you wish to implement token authentication for: 

    $ rails g henlo:migrations <MODEL>

Replace `<MODEL>` with the name of your model (e.g. `rails g henlo:migrations User)


## Usage

Henlo was written to work with different authentication strategies, but you will need to have set up Knock successfully in order to use Henlo. 

Call `Henlo.generate_henlos` in your app to receive a hash consisting of an Id Token, a Refresh Token, the Id Token's expiry time in unix seconds, and the Refresh Token's jwt identifier. Pass any information you would like to have encoded in the jwt's payload as an argument in a hash to this method. It is suggested you pass `{sub: <MODEL>.id}`, since a method `Henlo::Authenticable.parse_resource` is exposed to return the resource as identified by the token, using this encoded key value as the id of the resource. 

Call `Henlo.store_jti` in your app to store the jti of the Refresh Token in your model. This jti will be used to identify any suspicious activity. 

For the duration of the Refresh Token's expiry time, the user is considered logged in and will not need to reauthenticate. You can customize the expiry time of the refresh and id tokens in the initializer file. Once the refresh token has expired (which implies the user has not accessed your app for an extended period of time), they should reauthenticate and verify their identity to receive a new set of tokens. 

The following methods are also exposed to allow validation of non-expired Refresh Tokens before issuing a new Refresh Token and a new Id Token: 

`Henlo::Authenticable.it_suspicious?` checks whether the resource has be flagged as needing a blacklist check, and if this method returns true, `Henlo::Authenticable.it_not_fren?` checks the table "Blacklisted Tokens" to see whether the token sent with the request has a jwt identifier encoded has been blacklisted. 

`Henlo::Authenticable.jti_match?` checks wither the resource's token identifier as stored in the database matches the request token's identifier. If there is no match, it means at some point this particular token has already been used for another request, issuing another new refresh token, implying a breach. 

`Henlo::Authenticable.it_me?` should be called in your app's user authentication method. This method performs the above checks and returns the resource if all checks are passed. This method also blacklists suspicious tokens when the jti_match check does not pass. 

`Henlo::Authenticable.it_expired` handles expired tokens. Requests with expired id tokens are rejected, whereas requests with expired refresh tokens are then procesesed by a reauthentication strategy as defined by the user. You should define a method in your app that dictates how users are reauthenticated, then pass this method when you call the method like so:`Henlo::Authenticable.it_expired(reauthentication_method, token, model)`


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/henlo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Henlo project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/henlo/blob/master/CODE_OF_CONDUCT.md).


## TODOs

* Write tests
* Write docs