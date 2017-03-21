require_relative './file_creator.rb'

def database_set_up
  remove_file "config/database.yml"
  file 'config/database.yml', render_file(path("database.yml"))
  gsub_file 'config/database.yml', /app_name/, app_name
  run 'rails db:drop'
end

def create_database
  run 'rails db:create'
end

def migrate_database
  run 'rails db:migrate'
end
