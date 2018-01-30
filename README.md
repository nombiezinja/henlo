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

You can customize the expiry time of the refresh and id tokens in the initializer file.

## Usage




Methods you must define in your app:

current_user 

verify_user

reissue_tokens

Uses Knock methods:

authenticate_user (therefore you must require the Knock module as per Knock docs)

Uses payload id to find resource

rescue from jwt expired and invalid authenticity token

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