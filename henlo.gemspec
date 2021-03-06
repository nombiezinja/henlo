$:.push File.expand_path("../lib", __FILE__)
require "henlo/version"

Gem::Specification.new do |spec|
  spec.name          = "henlo"
  spec.version       = Henlo::VERSION
  spec.authors       = ["nombiezinja"]
  spec.email         = ["tianyizhang1987@gmail.com"]

  spec.summary       = "JWT based authentication with access and id tokens"
  spec.description   = "Based on the Knock gem, offers options to further customize secure authentication practices"
  spec.homepage      = "https://github.com/nombiezinja/henlo"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  spec.add_dependency "rails", ">= 4.2"
  spec.add_dependency "jwt", "~> 1.5"
  spec.add_dependency "knock", "~> 2.1.1"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rdoc"
end
