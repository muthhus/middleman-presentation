source 'https://rubygems.org'

gemspec

group :middleman do
  gem 'middleman', '~>3.3.2'
  gem 'middleman-livereload' #, '~> 3.1.0'
  gem 'wdm', '~> 0.1.0', :platforms => [:mswin, :mingw]
  gem 'tzinfo-data', platforms: [:mswin, :mingw]
end

gem 'thor'

group :development, :test do
  gem 'rspec', require: false
  gem 'rspec-legacy_formatters', require: false
  gem 'fuubar', require: false
  gem 'simplecov', require: false
  gem 'rubocop', require: false
  gem 'coveralls', require: false
  gem 'cucumber', require: false
  gem 'aruba', require: false, git: 'https://github.com/dg-vrnetze/aruba.git', branch: 'integration/expand_path'
  gem 'bundler', require: false
  gem 'erubis'
  gem 'versionomy', require: false
  gem 'activesupport', require: false
  gem 'awesome_print', require: 'ap'

  unless ENV['CI']
    gem 'byebug'
    gem 'pry'
    gem 'pry-byebug', require: false
    gem 'pry-doc', require: false
  end

  gem 'foreman', require: false
  gem 'github-markup'
  gem 'redcarpet', require: false
  gem 'tmrb', require: false
  gem 'yard', require: false
  gem 'inch', require: false
  gem 'license_finder'
  gem 'filegen', require: false
  gem 'travis-lint', require: false
  gem 'command_exec', require: false
end
