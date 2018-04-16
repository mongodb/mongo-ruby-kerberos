source 'https://rubygems.org'

gem 'rake'
gemspec

group :development, :test do
  gem 'rspec'
  gem 'rake-compiler'

  if ENV['CI']
    gem 'coveralls', :require => false
    gem 'mime-types', '1.25' # v2.0+ does not supporty ruby 1.8
  else
    gem 'ruby-prof', :platforms => :mri
    gem 'pry'
    gem 'guard-rspec', :platforms => [ :ruby_19, :ruby_24, :ruby_25 ]
    gem 'rb-inotify', :require => false # Linux
    gem 'rb-fsevent', :require => false # OS X
    gem 'rb-fchange', :require => false # Windows
    gem 'terminal-notifier-guard'
  end
end
