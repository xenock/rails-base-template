require_relative 'lib/gemfile_configurator.rb'
require_relative 'lib/file_modifier.rb'
require_relative 'lib/database_generator.rb'
require_relative 'lib/git_initializer.rb'
require_relative 'lib/devise_configurator.rb'
require_relative 'lib/minitest_reporters_configurator.rb'
require_relative 'lib/simple_form_configurator.rb'
require_relative 'lib/guard_configurator.rb'

run 'gem install spring-commands-rspec'

#Gemfile
remove_gemfile
custom_gemfile

#Database
database_set_up

# Generators
generators = <<-RUBY
config.generators do |generate|
    generate.assets false
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts', 'images')
  end
RUBY

environment generators

after_bundle do
  run 'spring stop'
  create_database
  configure_minitest_reporters
  configure_simple_form
  configure_guard
  configure_devise

  migrate_database

  remove_gitignore
  custom_gitignore

  initialize_git
end
