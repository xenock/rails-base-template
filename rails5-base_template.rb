run 'gem install bitters'
run 'gem install spring-commands-rspec'
run "rm Gemfile"

# Base Gem
file 'Gemfile', <<-RUBY
source 'https://rubygems.org'
ruby '#{RUBY_VERSION}'

gem 'rails'
gem 'pg'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'jbuilder'
gem 'bourbon'
gem 'neat'
gem 'simple_form'
gem 'devise'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'guard-rspec', require: false
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem "refills"
  gem "better_errors"
  gem 'rails-erd'
end

RUBY

# Bourbon
run 'rm app/assets/stylesheets/application.css'
file 'app/assets/stylesheets/application.scss', <<-CSS
  @import "bourbon";
  @import "neat";
  @import "base/base";
CSS

# Generators
generators = <<-RUBY
config.generators do |generate|
    generate.assets false
  end
RUBY

environment generators

after_bundle do
  run 'spring stop'
  rails_command 'db:drop db:create db:migrate'
  inside('app/assets/stylesheets') do
    run 'bitters install'
  end
  generate 'simple_form:install'
  generate 'rspec:install'
  run 'bundle exec guard init rspec'
  generate 'devise:install'
  generate 'devise User name:string surname:string telephone:integer address:string'
  generate 'devise:views'
  environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }", env: 'development'
  run "rm .gitignore"
  file '.gitignore', <<-TXT
    .bundle
    log/*.log
    tmp/**/*
    tmp/*
    *.swp
    .DS_Store
    public/assets
  TXT

  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end
