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
gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'simple_form'
gem 'devise'
gem 'kaminari'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'minitest-reporters'
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'

  gem "better_errors"
  gem 'rails-erd'
  gem 'guard-rails', require: false
  gem 'guard-livereload', require: false
end

RUBY

# Bootstrap
run 'rm app/assets/stylesheets/application.css'
file 'app/assets/stylesheets/application.scss', <<-CSS
  @import "bootstrap";
CSS

run 'rm app/assets/javascripts/application.js'
file 'app/assets/javascripts/application.js', <<-JS
  //= require jquery
  //= require jquery_ujs
  //= require turbolinks
  //= require boostrap-sprockets
  //= require_tree .
JS

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
  inject_into_file 'test/test_helper.rb', after: "require 'rails/test_help'\n" do <<-'RUBY'
require 'minitest/reporters'
Minitest::Reporters.use!(
  Minitest::Reporters::ProgressReporter.new,
  ENV,
  Minitest.backtrace_filter)
  RUBY
  end
  generate 'simple_form:install'
  run 'guard init rails'
  generate 'devise:install'
  generate 'devise User name:string surname:string telephone:integer address:string'
  generate 'devise:views'
  rails_command 'db:migrate'
  environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }", env: 'development'
  run "rm .gitignore"
  file '.gitignore', <<-TXT
.bundle
/log
/tmp
public/assets
TXT

  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end
