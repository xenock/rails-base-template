run 'gem install bitters'
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

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem "refills"
  gem "better_errors"
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
  rails_command 'db:drop db:create db:migrate'
  inside('app/assets/stylesheets') do
    run 'bitters install'
  end
  rails_command 'simple_form:install'
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
