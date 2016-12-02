run "rm Gemfile"
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

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end

RUBY

generators = <<-RUBY
config.generators do |generate|
      generate.assets false
    end
RUBY

environment generators
