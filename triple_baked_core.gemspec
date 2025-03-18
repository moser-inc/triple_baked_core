require_relative "lib/triple_baked_core/version"

Gem::Specification.new do |gem|
  gem.name        = "triple_baked_core"
  gem.version     = TripleBakedCore::VERSION
  gem.authors     = [ "Winston Kotzan" ]
  gem.email       = [ "winston.kotzan@moserit.com" ]
  gem.homepage    = "https://github.com/moser-inc/triple_baked_core"
  gem.summary     = "A simple CMS system based on TwiceBaked"
  gem.description = "A simple CMS system based on TwiceBaked"
  gem.license     = "MIT"
  gem.post_install_message = "Don't forget to run tb_core:install:migrations to add any new migrations."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  gem.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  gem.metadata["homepage_uri"] = gem.homepage
  gem.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  gem.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  gem.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  gem.add_dependency "rails", ">= 7.0"

  gem.add_development_dependency "dotenv", ">= 3.1.7"
  gem.add_development_dependency "factory_bot_rails", ">= 6.4"
  gem.add_development_dependency "jsbundling-rails", "~> 1.3"
  gem.add_development_dependency "rspec-rails", "~> 7.1"
  gem.add_development_dependency "stimulus-rails", "~> 1.3"
  gem.add_development_dependency "turbo-rails", "~> 2.0"
end
