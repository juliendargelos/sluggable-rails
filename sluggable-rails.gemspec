$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sluggable/rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sluggable-rails"
  s.version     = Sluggable::Rails::VERSION
  s.authors     = ["Julien Dargelos"]
  s.email       = ["contact@juliendargelos.com"]
  s.homepage    = "https://www.github.com/juliendargelos/sluggable-rails"
  s.summary     = "Slugify your rails records."
  s.description = "Provide a unique slug to your records, generated from the attribute of your choice."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"

  s.add_development_dependency "sqlite3"
end
